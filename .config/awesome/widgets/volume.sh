#!/bin/sh

vol() {
	vol="$(pamixer --get-volume-human)"

	case "$vol" in
		"muted") echo "婢  OFF" ;;
		6[0-5]% | 5[0-9]% | 4[0-9]% | 3[3-9]%) echo "奔  $vol" ;;
		3[0-2]% | 2[0-9]% | 1[0-9]% | [0-9]%) echo "奄  $vol" ;;
		*) echo "墳  $vol" ;;
	esac
}

vol
