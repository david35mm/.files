#!/bin/sh

brightness_level="$(brightnessctl -m | busybox cut -d',' -f4)"
# brightness_level="$(awk '{echo "%0.0f\n",$0 * 100 / 255}' /sys/class/backlight/*/brightness)"

case "$brightness_level" in
  100% | 9[0-9]% | 8[6-9]%) busybox printf '%s' " $brightness_level" ;;
  8[0-5]% | 7[1-9]%) busybox printf '%s' " $brightness_level" ;;
  70% | 6[0-9]% | 5[7-9]%) busybox printf '%s' " $brightness_level" ;;
  5[0-6]% | 4[3-9]%) busybox printf '%s' " $brightness_level" ;;
  4[0-2]% | 3[0-9]% | 29%) busybox printf '%s' " $brightness_level" ;;
  2[0-8]% | 1[4-9]%) busybox printf '%s' " $brightness_level" ;;
  *) busybox printf '%s' " $brightness_level" ;;
esac
