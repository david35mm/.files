#!/bin/sh
export VERSION_CONTROL=numbered

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
FallbackDNS=194.242.2.5#extended.dns.mullvad.net 2a07:e340::5#extended.dns.mullvad.net
DNSSEC=allow-downgrade
DNSOverTLS=opportunistic
Domains=~.
EOF

sudo mv -vb /etc/systemd/timesyncd.conf /etc/systemd/timesyncd.conf.bak
cat << EOF | sudo tee /etc/systemd/timesyncd.conf
[Time]
NTP=ntp1.inm.gov.co ntp2.inm.gov.co
FallbackNTP=0.co.pool.ntp.org 0.south-america.pool.ntp.org 1.south-america.pool.ntp.org
EOF

sudo systemctl enable --now systemd-timesyncd
sudo timedatectl set-ntp true
sudo hwclock --systohc
sudo timedatectl set-local-rtc 0

sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
systemctl restart systemd-resolved systemd-timesyncd NetworkManager
