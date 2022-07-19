#!/bin/sh

case "$(busybox grep -w NAME /etc/os-release | busybox sed 's/NAME=//;s/\"//g' | busybox cut -d' ' -f1)" in
  "Fedora")
    number_updates="$(dnf updateinfo -q --list | busybox wc -l)"
    image_name="fedora-logo-icon.svg"
    package_manager_name="DNF"
    package_names="$(dnf -q list updates | busybox cut -d'.' -f1 | busybox sed '1d')"
    # package_names="$(dnf -q list updates | busybox awk -F. '(NR > 1) {print $1}')"
    ;;
  *)
    number_updates="$(checkupdates | busybox wc -l)"
    image_name="archlinux.svg"
    package_manager_name="Pacman"
    package_names="$(checkupdates)"
    ;;
esac

[ "$number_updates" -gt 0 ] \
  && notify-send -i /usr/share/icons/Tela-circle-dark/scalable/apps/"$image_name" -u low -t 15000 "$package_manager_name" "You have $number_updates updates:\n$package_names" \
  || notify-send -i /usr/share/icons/Tela-circle-dark/scalable/apps/"$image_name" -u low -t 2500 "$package_manager_name" "You are up to date!"
