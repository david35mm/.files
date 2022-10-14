#!/bin/sh

if command -v dnf; then
  pkexec /usr/bin/dnf -y update
else
  pkexec /usr/bin/pacman -Syu --noconfirm --needed
fi
