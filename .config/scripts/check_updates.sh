#!/bin/sh

ICON_PATH="/usr/share/icons/Tela-circle-dark/scalable/apps"
notify_icon=""
package_manager=""
updates_count=0
package_list=""

if command -v dnf >/dev/null 2>&1; then
  notify_icon="$ICON_PATH/fedora-logo-icon.svg"
  package_manager="DNF"
  package_list="$(dnf -q rq --upgrades --qf '%{name}')"
  updates_count=$(printf "%s\n" "$package_list" | wc -l)
elif command -v checkupdates >/dev/null 2>&1; then
  notify_icon="$ICON_PATH/archlinux.svg"
  package_manager="Pacman"
  package_list="$(checkupdates)"
  updates_count=$(printf "%s\n" "$package_list" | wc -l)
else
  notify-send "Update Checker" "No supported package manager found."
  exit 1
fi

if [ "$updates_count" -gt 0 ]; then
  notify-send -i "$notify_icon" -u low -t 15000 "$package_manager" "You have $updates_count updates:\n$package_list"
else
  notify-send -i "$notify_icon" -u low -t 2500 "$package_manager" "You are up to date!"
fi

