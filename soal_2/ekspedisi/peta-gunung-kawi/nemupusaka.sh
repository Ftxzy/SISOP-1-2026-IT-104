#!/bin/bash

INPUT="titik-penting.txt"
OUTPUT="posisipusaka.txt"

awk -F',' '
NR==2 { x1=$3; y1=$4 }
NR==4 { x2=$3; y2=$4 }
END {
    mid_lat = (x1 + x2) / 2
    mid_lon = (y1 + y2) / 2
    print"(" mid_lat "," mid_lon")"
}' "$INPUT" > "$OUTPUT"

echo "Berhasiiiiil"
