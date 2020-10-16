#!/bin/bash
# Example Bar Action Script for Linux.
# Requires: acpi and lm_sensors.

##############################
#	    RAM
##############################

mem() {
	mem="$(free | awk '/Mem/ {printf "%d\n", $3 / 1024.0}')"
	echo -e "$mem MB"
}

##############################
#	    CPU
##############################

cpu() {
	read cpu a b c previdle rest < /proc/stat
	prevtotal=$((a+b+c+previdle))
	sleep 1
	read cpu a b c idle rest < /proc/stat
	total=$((a+b+c+idle))
	cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
	echo -e "$cpu%"
}

##############################
#	    VOLUME
##############################

vol() {
	vol="$(amixer -D pulse get Master | awk -F'[][]' 'END{print $2}')"

	if [[ "$(amixer -D pulse get Master | awk -F'[][]' 'END{print $4}' | grep -c "off")" -eq 1 ]]
	then
		echo "+@fn=2; 婢 +@fn=0;OFF"
	else
		echo -e "+@fn=2; 墳 +@fn=0;$vol"
	fi
}

##############################
#	    BATTERY
##############################
bat() {
	bat="$(acpi -b | awk '{printf $4}' | cut -d "," -f1)"

	if [[ "$(acpi -b|grep -c "Full")" -eq 1 ]]
	then
		echo ""
	else
		echo "$bat"
	fi
}

##############################
#	    BATTERY STATUS
##############################
stat() {
	ac_power="$(acpi -b|grep -c "Charging")"

	if [[ "$(acpi -b|grep -c "Full")" -eq 1 ]]
	then
		echo "  +@fn=0;Full"
	elif [ $ac_power -eq 1 ]
		then
			echo " "
		else
			echo " "
	fi
}

##############################
#	    CPU TEMP
##############################
cputmp() {
	temp="$(sensors | awk '/edge/ {printf $2}' | cut -d "+" -f2)"
	echo "$temp"
}

##############################
#	    BAR OUTPUT
##############################
SLEEP_SEC=0.3
#loops forever outputting a line every SLEEP_SEC secs
while :; do
	echo "+@fn=2;+@fg=4; +@fg=0;+@bg=3; ﬙ +@fn=0;$(cpu) +@fn=2;+@fg=5; +@fg=0;+@bg=4;  +@fn=0;$(mem) +@fn=2;+@fg=6; +@fg=0;+@bg=5;  +@fn=0;$(cputmp) +@fn=2;+@fg=7; +@fg=0;+@bg=6;$(vol) +@fn=2;+@fg=8; +@fg=0;+@bg=7;$(stat)+@fn=0; $(bat) +@fn=2;+@fg=9; +@fg=0;+@fn=0;+@bg=8;"
	sleep $SLEEP_SEC
done
