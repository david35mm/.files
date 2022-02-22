#!/bin/sh

mem() {
  busybox free -m | busybox awk '(NR == 2) {print $3 "\ MB"}'
}

mem
