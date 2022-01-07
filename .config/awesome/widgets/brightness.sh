#!/bin/sh

brghtnss() {
	bri="$(brightnessctl -m | cut -d',' -f4)"
	#bri="$(awk '{echo "%0.0f\n",$0 * 100 / 255}' /sys/class/backlight/*/brightness)"

	case "$bri" in
		100% | 9[0-9]% | 8[6-9]%) echo "  $bri" ;;
		8[0-5]% | 7[1-9]%) echo "  $bri" ;;
		70% | 6[0-9]% | 5[7-9]%) echo "  $bri" ;;
		5[0-6]% | 4[3-9]%) echo "  $bri" ;;
		4[0-2]% | 3[0-9]% | 29%) echo "  $bri" ;;
		2[0-8]% | 1[4-9]%) echo "  $bri" ;;
		*) echo "  $bri" ;;
	esac
}

brghtnss
