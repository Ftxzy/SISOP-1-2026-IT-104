#!/bin/bash

INPUT="gsxtrack.json"
OUTPUT="titik-penting.txt"

echo "id,site_name,latitude,longitude" > "$OUTPUT"

awk '
/"id":/ && /"node_/ {
    gsub(/.*"id": "/,""); gsub(/",.*/,""); id=$0
}
/"site_name":/ {
    gsub(/.*"site_name": "/,""); gsub(/",.*/,""); site=$0
}
/"latitude":/ {
    gsub(/.*"latitude": /,""); gsub(/,.*/,""); lat=$0
}
/"longitude":/ {
    gsub(/.*"longitude": /,""); gsub(/,.*/,""); lon=$0
    print id","site","lat","lon
}' "$INPUT" >> "$OUTPUT"

echo "Selesai transfer woiiiighhhhhhhhhhhh"

