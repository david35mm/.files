#!/bin/sh
numberUpdates="$(checkupdates | busybox wc -l)"
[ "$numberUpdates" -gt 0 ] && notify-send -i /usr/share/icons/Tela-circle-dark/scalable/apps/archlinux.svg -u low -t 15000 "Pacman" "You have $numberUpdates updates:\n$(checkupdates)" || notify-send -i /usr/share/icons/Tela-circle-dark/scalable/apps/archlinux.svg -u low -t 2500 "Pacman" "You are up to date!"
