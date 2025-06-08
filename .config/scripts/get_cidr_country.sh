#!/bin/sh

# Check if country code was provided
if [ -z "$1" ]; then
    echo "Usage: $0 <COUNTRY_CODE>"
    exit 1
fi

COUNTRY="$1"

# Stream and process LACNIC delegation file for the specified country
curl -s "ftp://ftp.lacnic.net/pub/stats/lacnic/delegated-lacnic-latest" | awk -F'|' -v cc="$COUNTRY" '
$2 == cc && $3 == "ipv4" {
    start_ip = $4
    num_ips = $5
    prefix_length = 32 - log(num_ips) / log(2)
    printf "%s/%d\n", start_ip, int(prefix_length)
}
$2 == cc && $3 == "ipv6" {
    start_ip = $4
    prefix_length = $5
    printf "%s/%d\n", start_ip, prefix_length
}'
