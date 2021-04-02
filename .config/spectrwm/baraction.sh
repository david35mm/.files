#!/bin/sh
# Example Bar Action Script for Linux.
# Requires: acpi and lm_sensors.

##############################
#	    RAM
##############################

mem() {
	free --mebi | sed '1d;3d;s/ \+/ /g' | cut -d' ' -f3
}

##############################
#	    CPU
##############################

#cpu() {
#	top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'
#}

##############################
#	    NETWORK
##############################

ntwrk() {
	case "$(nmcli general | awk '(NR > 1) {print $1}')" in
		"connected") echo "+@fn=2; +@fn=0;$(nmcli connection | awk '(NR==2) {print $1}')" ;;
		*) echo "+@fn=2; +@fn=0;You are offline" ;;
	esac
}

##############################
#	    VOLUME
##############################

vol() {
	vol="$(amixer get Master | sed 's/%//g' | awk -F'[][]' 'END{print $2}')"

	case "$(amixer get Master | awk -F'[][]' 'END{print $4}')" in
		"on")
			case "$vol" in
				100|9[0-9]|8[0-9]|7[0-9]|6[6-9]) echo "+@fn=2;墳 +@fn=0;$vol%" ;;
				6[0-5]|5[0-9]|4[0-9]|3[3-9]) echo "+@fn=2;奔 +@fn=0;$vol%" ;;
				*) echo "+@fn=2;奄 +@fn=0;$vol%" ;;
			esac
		;;
		"off") echo "+@fn=2;婢 +@fn=0;OFF"
	esac
}

##############################
#	    BATTERY
##############################
bat() {
	bat=$(cat /sys/class/power_supply/BAT1/capacity)

	case "$(cat /sys/class/power_supply/BAT1/status)" in
		"Full") echo "+@fn=2; +@fn=0;Full" ;;
		"Discharging") 
			case "$bat" in
				100|9[1-9]) echo "+@fn=2; +@fn=0;$bat%" ;;
				90|8[2-9]) echo "+@fn=2; +@fn=0;$bat%" ;;
				8[0-1]|7[3-9]) echo "+@fn=2; +@fn=0;$bat%" ;;
				7[0-2]|6[4-9]) echo "+@fn=2; +@fn=0;$bat%" ;;
				6[0-3]|5[5-9]) echo "+@fn=2; +@fn=0;$bat%" ;;
				5[0-4]|4[5-9]) echo "+@fn=2; +@fn=0;$bat%" ;;
				4[0-4]|3[6-9]) echo "+@fn=2; +@fn=0;$bat%" ;;
				3[0-5]|2[7-9]) echo "+@fn=2; +@fn=0;$bat%" ;;
				2[0-6]|1[8-9]) echo "+@fn=2; +@fn=0;$bat%" ;;
				1[0-7]|9) echo "+@fg=2;+@fn=2; +@fn=0;$bat%" ;;
				*) echo "+@fg=2;+@fn=2; +@fn=0;$bat%" ;;
			esac
		;;
		"Charging")
			case "$bat" in
				100|9[0-9]|8[1-9]) echo "+@fn=2; +@fn=0;$bat%" ;;
				80|7[0-9]|6[1-9]) echo "+@fn=2; +@fn=0;$bat%" ;;
				60|5[0-9]|4[1-9]) echo "+@fn=2; +@fn=0;$bat%" ;;
				40|3[0-9]|2[1-9]) echo "+@fn=2; +@fn=0;$bat%" ;;
				*) echo "+@fg=2;+@fn=2; +@fn=0;$bat%" ;;
			esac
		;;
		"Unknown") echo "+@fn=2; +@fn=0;$bat%" ;;
	esac
}

##############################
#	    CPU TEMP
##############################
#cputmp() {
#	sensors | sed 's\+\\g' | awk '/Tdie/ {print $2}'
#}

##############################
#       BRIGHTNESS
##############################
brghtnss() {
	bri="$(brightnessctl -m | sed 's/,/ /g;s/%//g' | cut -d' ' -f4)"

	case "$bri" in
		100|9[0-9]|8[6-9]) echo "+@fn=2; +@fn=0;$bri%" ;;
		8[0-5]|7[1-9]) echo "+@fn=2; +@fn=0;$bri%" ;;
		70|6[0-9]|5[7-9]) echo "+@fn=2; +@fn=0;$bri%" ;;
		5[0-6]|4[3-9]) echo "+@fn=2; +@fn=0;$bri%" ;;
		4[0-2]|3[0-9]|29) echo "+@fn=2; +@fn=0;$bri%" ;;
		2[0-8]|1[4-9]) echo "+@fn=2; +@fn=0;$bri%" ;;
		*) echo "+@fn=2; +@fn=0;$bri%" ;;
	esac
}

##############################
#       CRYPTO TICKER
##############################
#crypt(){
#	curl rate.sx/1doge
#}

##############################
#	    BAR OUTPUT
##############################
while :; do
	echo "+@fg=2;$(ntwrk) +@fg=1;| +@fn=2;+@fg=3;﬙ +@fn=0;$(mem) MB +@fg=1;| +@fg=4;$(brghtnss) +@fg=1;| +@fg=5;$(vol) +@fg=1;| +@fg=6;$(bat) +@fg=1;| +@fn=2;+@fg=7; +@fn=0;"
	sleep 10
done