#!/bin/sh

if command -v dnf; then
  number_updates="$(dnf updateinfo -q --list | busybox wc -l)"
  image_name="fedora-logo-icon.svg"
  package_manager_name="DNF"
  # package_names="$(dnf -q --color never list updates | busybox cut -d'.' -f1 | busybox sed '1d')"
  package_names="$(dnf -q --color never list updates | busybox awk -F . 'NR > 1 {print $1}')"
else
  number_updates="$(checkupdates | busybox wc -l)"
  image_name="archlinux.svg"
  package_manager_name="Pacman"
  package_names="$(checkupdates)"
fi

if [ "$number_updates" -gt 0 ]; then
  notify-send -i /usr/share/icons/Tela-circle-dark/scalable/apps/"$image_name" -u low -t 15000 "$package_manager_name" "You have $number_updates updates:\n$package_names"
else
  notify-send -i /usr/share/icons/Tela-circle-dark/scalable/apps/"$image_name" -u low -t 2500 "$package_manager_name" "You are up to date!"
fi
