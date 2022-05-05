#!/bin/sh

case "$(busybox grep -w NAME /etc/os-release | busybox sed 's/NAME=//;s/\"//g' | busybox cut -d' ' -f1)" in
  "Fedora")
    pkexec /usr/bin/dnf -y update
    ;;
  *)
    pkexec /usr/bin/pacman -Syu --noconfirm --needed
    ;;
esac
