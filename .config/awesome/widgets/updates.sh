#!/bin/sh

up() {
  updates=$(checkupdates | busybox wc -l)
  [ "$updates" -eq 0 ] && busybox echo "Up to date!" \
  || busybox echo "$updates Updates"
}

up
