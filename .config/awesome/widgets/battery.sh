#!/bin/sh

bat() {
	bat=$(cat /sys/class/power_supply/BAT1/capacity)

	case "$(cat /sys/class/power_supply/BAT1/status)" in
		"Full") echo "  Full" ;;
		"Discharging")
			case "$bat" in
				100 | 9[1-9]) echo "  $bat%" ;;
				90 | 8[2-9]) echo "  $bat%" ;;
				8[0-1] | 7[3-9]) echo "  $bat%" ;;
				7[0-2] | 6[4-9]) echo "  $bat%" ;;
				6[0-3] | 5[5-9]) echo "  $bat%" ;;
				5[0-4] | 4[5-9]) echo "  $bat%" ;;
				4[0-4] | 3[6-9]) echo "  $bat%" ;;
				3[0-5] | 2[7-9]) echo "  $bat%" ;;
				2[0-6] | 1[8-9]) echo "  $bat%" ;;
				1[0-7] | 9) echo "  $bat%" ;;
				*) echo "  $bat%" ;;
			esac
			;;
		"Charging")
			case "$bat" in
				100 | 9[0-9] | 8[1-9]) echo "  $bat%" ;;
				80 | 7[0-9] | 6[1-9]) echo "  $bat%" ;;
				60 | 5[0-9] | 4[1-9]) echo "  $bat%" ;;
				40 | 3[0-9] | 2[1-9]) echo "  $bat%" ;;
				*) echo "  $bat%" ;;
			esac
			;;
		"Unknown") echo "  $bat%" ;;
	esac
}

bat
