#!/bin/sh

up() {
	updates=$(checkupdates | wc -l)
	[ "$updates" -eq 0 ] && echo "Up to date!" || echo "$updates Updates"
}

up
