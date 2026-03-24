# SISOP-1-2026-IT-104

Khalifa Suryadinarta 5027251104

## Soal 1

Penjelasan

Langkah pertama download data file passenger.csv

setelah itu memastikan berapa penumpang kereta total

```bash
echo "=== KERETA HOMOOOOO HOMOOOOOOOOOO GAYYYYYYYYYYY ==="

read -p "Pilih pilihan a/b/c/d/e: " answer

case "$answer" in

    "a")
        awk -F',' '
        NR>1 { total++ }
        END  { print "Total seluruh penumpang: " total }
        ' passenger.csv
        ;;
```

awk -F merupakan field seperator. Membaca bagaimana collumn terbagi. NR>1 karena kita tidak membaca header dan akhirnya print total jumlah seluruh penumpang dalam file passenger.csv
 
