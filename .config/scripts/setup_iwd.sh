#!/bin/sh
export VERSION_CONTROL=numbered

# Require root once instead of using sudo everywhere
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run this script as root (e.g. with sudo)." >&2
  exit 1
fi

# Install iwd and disable wpa_supplicant
dnf --refresh -y install iwd
systemctl mask wpa_supplicant

# Create NetworkManager config files
tee /etc/NetworkManager/conf.d/wifi_backend.conf >/dev/null << EOF
[device]
wifi.backend=iwd
EOF

tee /etc/NetworkManager/conf.d/wifi_rand_mac.conf >/dev/null << EOF
[device-mac-randomization]
wifi.scan-rand-mac-address=yes

[connection-mac-randomization]
ethernet.cloned-mac-address=random
wifi.cloned-mac-address=stable
EOF

tee /etc/NetworkManager/conf.d/ip6-privacy.conf >/dev/null << EOF
[connection]
ipv6.ip6-privacy=2
EOF

# Backup and replace systemd-resolved configuration
cp -vb /etc/systemd/resolved.conf /etc/systemd/resolved.conf.bak
tee /etc/systemd/resolved.conf >/dev/null << EOF
[Resolve]
DNS=9.9.9.9#dns.quad9.net 149.112.112.112#dns.quad9.net 2620:fe::fe#dns.quad9.net 2620:fe::9#dns.quad9.net
FallbackDNS=194.242.2.5#extended.dns.mullvad.net 2a07:e340::5#extended.dns.mullvad.net
DNSSEC=allow-downgrade
DNSOverTLS=opportunistic
Domains=~.
EOF

# Backup and replace systemd-timesyncd configuration
cp -vb /etc/systemd/timesyncd.conf /etc/systemd/timesyncd.conf.bak
tee /etc/systemd/timesyncd.conf >/dev/null << EOF
[Time]
NTP=ntp1.inm.gov.co ntp2.inm.gov.co
FallbackNTP=0.co.pool.ntp.org 0.south-america.pool.ntp.org 1.south-america.pool.ntp.org
EOF

# Enable time sync and configure hardware clock
systemctl enable --now systemd-timesyncd
timedatectl set-ntp true
hwclock --systohc
timedatectl set-local-rtc 0

# Symlink resolv.conf to systemd stub
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# Restart services
systemctl restart systemd-resolved systemd-timesyncd NetworkManager

