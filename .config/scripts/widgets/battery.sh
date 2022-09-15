#!/bin/sh

battery_level=$(busybox cat /sys/class/power_supply/BAT?/capacity)

case "$(busybox cat /sys/class/power_supply/BAT?/status)" in
  "Full") busybox printf '%s' " Full" ;;
  "Discharging")
    case "$battery_level" in
      100 | 9[1-9]) busybox printf '%s' " $battery_level%" ;;
      90 | 8[2-9]) busybox printf '%s' " $battery_level%" ;;
      8[0-1] | 7[3-9]) busybox printf '%s' " $battery_level%" ;;
      7[0-2] | 6[4-9]) busybox printf '%s' " $battery_level%" ;;
      6[0-3] | 5[5-9]) busybox printf '%s' " $battery_level%" ;;
      5[0-4] | 4[5-9]) busybox printf '%s' " $battery_level%" ;;
      4[0-4] | 3[6-9]) busybox printf '%s' " $battery_level%" ;;
      3[0-5] | 2[7-9]) busybox printf '%s' " $battery_level%" ;;
      2[0-6] | 1[8-9]) busybox printf '%s' " $battery_level%" ;;
      1[0-7] | 9) busybox printf '%s' " $battery_level%" ;;
      *) busybox printf '%s' " $battery_level%" ;;
    esac
    ;;
  "Charging")
    case "$battery_level" in
      100 | 9[0-9] | 8[1-9]) busybox printf '%s' " $battery_level%" ;;
      80 | 7[0-9] | 6[1-9]) busybox printf '%s' " $battery_level%" ;;
      60 | 5[0-9] | 4[1-9]) busybox printf '%s' " $battery_level%" ;;
      40 | 3[0-9] | 2[1-9]) busybox printf '%s' " $battery_level%" ;;
      *) busybox printf '%s' " $battery_level%" ;;
    esac
    ;;
  "Unknown") busybox printf '%s' " $battery_level%" ;;
esac
