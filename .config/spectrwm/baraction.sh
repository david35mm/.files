#!/bin/sh
# Example Bar Action Script for Linux.
# Requires: acpi and lm_sensors.

##############################
#	    RAM
##############################

show_memory() {
  busybox free -m | busybox awk '(NR == 2) {printf $3 "\ MB"}'
}

##############################
#	    CPU
##############################

# show_cpu_usage() {
# 	top -bn1 | busybox grep "Cpu(s)" | busybox sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | busybox awk '{printf 100 - $1"%"}'
# }

##############################
#	    NETWORK
##############################

show_network_status() {
  case "$(nmcli general | busybox awk '(NR == 2) {printf $1}')" in
    "connected") busybox printf '%s' " $(nmcli connection | busybox awk '(NR==2) {print $1}')" ;;
    *) busybox printf '%s' " You are offline" ;;
  esac
}

##############################
#	    WEATHER
##############################

# show_weather() {
# 	curl wttr.in/~"$1"\?format="%C%20%t%20%w"
# }

##############################
#	    VOLUME
##############################

show_volume() {
  volume_level="$(pamixer --get-volume-human)"

  case "$volume_level" in
    "muted") busybox printf '%s' "婢 OFF" ;;
    6[0-5]% | 5[0-9]% | 4[0-9]% | 3[3-9]%) busybox printf '%s' "奔 $volume_level" ;;
    3[0-2]% | 2[0-9]% | 1[0-9]% | [0-9]%) busybox printf '%s' "奄 $volume_level" ;;
    *) busybox printf '%s' "墳 $volume_level" ;;
  esac
}

##############################
#	    BATTERY
##############################
show_battery() {
  battery_level=$(busybox cat /sys/class/power_supply/BAT1/capacity)

  case "$(busybox cat /sys/class/power_supply/BAT1/status)" in
    "Full") busybox printf '%s' " Full" ;;
    "Discharging")
      case "$battery_level" in
        100 | 9[1-9]) busybox printf '%s' " $battery_level%" ;;
        90 | 8[2-9]) busybox printf '%s' " $battery_level%" ;;
        8[0-1] | 7[3-9]) busybox printf '%s' " $battery_level%" ;;
        7[0-2] | 6[4-9]) busybox printf '%s' " $battery_level%" ;;
        6[0-3] | 5[5-9]) busybox printf '%s' " $battery_level%" ;;
        5[0-4] | 4[5-9]) busybox printf '%s' " $battery_level%" ;;
        4[0-4] | 3[6-9]) busybox printf '%s' " $battery_level%" ;;
        3[0-5] | 2[7-9]) busybox printf '%s' " $battery_level%" ;;
        2[0-6] | 1[8-9]) busybox printf '%s' " $battery_level%" ;;
        1[0-7] | 9) busybox printf '%s' " $battery_level%" ;;
        *) busybox printf '%s' " $battery_level%" ;;
      esac
      ;;
    "Charging")
      case "$battery_level" in
        100 | 9[0-9] | 8[1-9]) busybox printf '%s' " $battery_level%" ;;
        80 | 7[0-9] | 6[1-9]) busybox printf '%s' " $battery_level%" ;;
        60 | 5[0-9] | 4[1-9]) busybox printf '%s' " $battery_level%" ;;
        40 | 3[0-9] | 2[1-9]) busybox printf '%s' " $battery_level%" ;;
        *) busybox printf '%s' " $battery_level%" ;;
      esac
      ;;
    "Unknown") busybox printf '%s' " $battery_level%" ;;
  esac
}

##############################
#	    CPU TEMP
##############################
# show_cpu_temp() {
# 	sensors | busybox sed 's\+\\g' | busybox awk '/Tdie/ {printf $2}'
# }

##############################
#       BRIGHTNESS
##############################
show_brightness() {
  brightness_level="$(brightnessctl -m | busybox cut -d',' -f4)"
  # brightness_level="$(awk '{echo "%0.0f\n",$0 * 100 / 255}' /sys/class/backlight/*/brightness)"

  case "$brightness_level" in
    100% | 9[0-9]% | 8[6-9]%) busybox printf '%s' " $brightness_level" ;;
    8[0-5]% | 7[1-9]%) busybox printf '%s' " $brightness_level" ;;
    70% | 6[0-9]% | 5[7-9]%) busybox printf '%s' " $brightness_level" ;;
    5[0-6]% | 4[3-9]%) busybox printf '%s' " $brightness_level" ;;
    4[0-2]% | 3[0-9]% | 29%) busybox printf '%s' " $brightness_level" ;;
    2[0-8]% | 1[4-9]%) busybox printf '%s' " $brightness_level" ;;
    *) busybox printf '%s' " $brightness_level" ;;
  esac
}

##############################
#       CRYPTO TICKER
##############################
# show_crypto(){
# 	crypto_rate="$(curl rate.sx/1grt)"
# 	busybox printf '%s' ${crypto_rate:0:6}
# }

##############################
#	    BAR OUTPUT
##############################
while :; do
  busybox printf '%s' "+@fg=2;$(show_network_status) +@fg=1;| +@fg=3;﬙ $(show_memory) +@fg=1;| +@fg=4;$(show_brightness) +@fg=1;| +@fg=5;$(show_volume) +@fg=1;| +@fg=6;$(show_battery) +@fg=1;| +@fg=7; "
  busybox sleep 10
done
