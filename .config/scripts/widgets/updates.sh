#!/bin/sh

case "$(busybox grep -w NAME /etc/os-release | busybox sed 's/NAME=//;s/\"//g' | busybox cut -d' ' -f1)" in
  "Fedora")
    number_updates="$(dnf updateinfo -q --list | busybox wc -l)"
    ;;
  *)
    number_updates="$(checkupdates | busybox wc -l)"
    ;;
esac

[ "$number_updates" -eq 0 ] \
  && busybox printf '%s' "Up to date!" \
  || busybox printf '%s' "$number_updates Updates"
