#!/bin/sh

vol() {
  vol="$(pamixer --get-volume-human)"

  case "$vol" in
    "muted") busybox echo "婢  OFF" ;;
    6[0-5]% | 5[0-9]% | 4[0-9]% | 3[3-9]%) busybox echo "奔  $vol" ;;
    3[0-2]% | 2[0-9]% | 1[0-9]% | [0-9]%) busybox echo "奄  $vol" ;;
    *) busybox echo "墳  $vol" ;;
  esac
}

vol
