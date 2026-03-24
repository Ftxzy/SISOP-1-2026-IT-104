#!/bin/bash

echo "=== KERETA HOMOOOOO HOMOOOOOOOOOO GAYYYYYYYYYYY ==="

read -p "Pilih pilihan a/b/c/d/e: " answer

case "$answer" in

    "a")
        awk -F',' '
        NR>1 { total++ }
        END  { print "Total seluruh penumpang: " total }
        ' passenger.csv
        ;;


    "b")
        awk -F',' '
        NR>1 { gerbong[$4] = 1 } #1 for initalizing nilaiaiwiadjaidwjia
        END  {
            for (g in gerbong) count++ #for accessing the key
            print "Total gerbong: " count
        }
        ' passenger.csv
        ;;


    "c")
        awk -F',' '
        NR==2 { oldest=$2; name=$1 }
        NR>1  {
            if ($2 > oldest) {
                oldest = $2
                name = $1
            }
        }
        END { print "PENUMPANGGGGGGGGGGGGG TUAAAAAAAA: " name " (" oldest " tahun)" }
        ' passenger.csv
        ;;


    "d")
        awk -F',' '
        NR>1 { total += $2 }
        END  { printf "Rata rata usia penumpang: %d tahun\n", total/(NR-1) }
        ' passenger.csv
        ;;

    "e")
        awk -F',' '
        NR>1 && $3=="Business" { total++ }
        END { print "Total penumpang Business Class: " total }
        ' passenger.csv
        ;;

    *)
        echo "milih yang benerr WOIGHHHHHHHHHHH"
        ;;
esac
