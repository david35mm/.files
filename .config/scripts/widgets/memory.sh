#!/bin/sh

busybox free -m | busybox awk '(NR == 2) {printf $3 "\ MB"}'
