#!/bin/sh

# Check if an argument (ASN) is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <ASN>"
  exit 1
fi

ASN="$1"
URL="https://ftp.lacnic.net/pub/stats/lacnic/delegated-lacnic-extended-latest"

# Stream the file and cache it temporarily
TMPFILE=$(mktemp)

curl -s "$URL" | tee "$TMPFILE" > /dev/null

# Find the internal identifier for the given ASN
INTERNAL_ID=$(awk -v asn="$ASN" -F'|' '
$3 == "asn" && $4 == asn {
  print $8
  exit
}
' "$TMPFILE")

# Check if the internal identifier was found
if [ -z "$INTERNAL_ID" ]; then
  echo "No internal identifier found for ASN $ASN."
  rm "$TMPFILE"
  exit 1
fi

# Extract and print IP ranges (IPv4 and IPv6) for the specified internal ID
awk -v internal_id="$INTERNAL_ID" -F'|' '
$3 == "ipv6" && $8 == internal_id {
  printf "%s/%d\n", $4, $5
}
$3 == "ipv4" && $8 == internal_id {
  start_ip = $4
  num_ips = $5
  prefix_length = 32 - log(num_ips) / log(2)
  printf "%s/%d\n", start_ip, int(prefix_length)
}
' "$TMPFILE"

# Clean up temporary file
rm "$TMPFILE"
