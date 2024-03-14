#!/bin/sh
VERSION_CONTROL=numbered

sudo dnf --refresh -y in iwd
sudo systemctl mask wpa_supplicant

cat << EOF | sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf
[device]
wifi.backend=iwd
EOF

cat << EOF | sudo tee /etc/NetworkManager/conf.d/wifi_rand_mac.conf
[device-mac-randomization]
# "yes" is already the default for scanning
wifi.scan-rand-mac-address=yes
 
[connection-mac-randomization]
# Randomize MAC for every ethernet connection
ethernet.cloned-mac-address=random
# Generate a random MAC for each WiFi and associate the two permanently.
wifi.cloned-mac-address=stable
EOF

cat << EOF | sudo tee /etc/NetworkManager/conf.d/ip6-privacy.conf
[connection]
ipv6.ip6-privacy=2
EOF

sudo mv -vb /etc/systemd/resolved.conf /etc/systemd/resolved.conf.bak
cat << EOF | sudo tee /etc/systemd/resolved.conf
[Resolve]
DNS=9.9.9.9#dns.quad9.net 149.112.112.112#dns.quad9.net 2620:fe::fe#dns.quad9.net 2620:fe::9#dns.quad9.net
FallbackDNS=1.1.1.2#security.cloudflare-dns.com 1.0.0.2#security.cloudflare-dns.com 2606:4700:4700::1112#security.cloudflare-dns.com 2606:4700:4700::1002#security.cloudflare-dns.com
DNSOverTLS=yes
DNSSEC=allow-downgrade
Domains=~.
EOF

sudo mv -vb /etc/systemd/timesyncd.conf /etc/systemd/timesyncd.conf.bak
cat << EOF | sudo tee /etc/systemd/timesyncd.conf
[Time]
NTP=ntp1.inm.gov.co ntp2.inm.gov.co
FallbackNTP=1.co.pool.ntp.org 0.south-america.pool.ntp.org 3.south-america.pool.ntp.org
EOF

sudo systemctl enable --now systemd-timesyncd
sudo timedatectl set-ntp true
sudo hwclock --systohc
sudo timedatectl set-local-rtc 0

# sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf