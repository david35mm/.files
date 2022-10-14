#!/bin/sh

if command -v dnf > /dev/null; then
  number_updates="$(dnf updateinfo -q --list | busybox wc -l)"
else
  number_updates="$(checkupdates | busybox wc -l)"
fi

if [ "$number_updates" -eq 0 ]; then
  busybox printf '%s' "Up to date!"
else
  busybox printf '%s' "$number_updates Updates"
fi
