#!/bin/sh

volume_level="$(pamixer --get-volume-human)"

case "$volume_level" in
  "muted") busybox printf '%s' "婢 OFF" ;;
  6[0-5]% | 5[0-9]% | 4[0-9]% | 3[3-9]%) busybox printf '%s' "奔 $volume_level" ;;
  3[0-2]% | 2[0-9]% | 1[0-9]% | [0-9]%) busybox printf '%s' "奄 $volume_level" ;;
  *) busybox printf '%s' "墳 $volume_level" ;;
esac
