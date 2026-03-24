# SISOP-1-2026-IT-104

Khalifa Suryadinarta 5027251104

## Soal 1

### Penjelasan

Langkah pertama download data file passenger.csv

### Code

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
opsi a memastikan berapa penumpang kereta total. awk -F merupakan field seperator. Membaca bagaimana collumn terbagi. NR>1 karena kita tidak membaca header dan akhirnya print total jumlah seluruh penumpang dalam file passenger.csv
 
```bash
    "b")
        awk -F',' '
        NR>1 { gerbong[$4] = 1 } #1 for initalizing nilaiaiwiadjaidwjia
        END  {
            for (g in gerbong) count++ #for accessing the key
            print "Total gerbong: " count
        }
        ' passenger.csv
        ;;
```
opsi b mengetahui jumlah gerbong ber operasi ada berapa. gerbong berada di kolum 4, logikanya jika kolum 4 ada nilainya, count akan bertambah hingga total gerbong akhirnya menjadi 5

```bash
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
```
opsi c mencari penumpang tertua dengan cara membandingkan kolum 2 satu sama lain hingga habis. akhirnya print dengan nilai oldest dan cocokkan namanya

```bash
"d")
        awk -F',' '
        NR>1 { total += $2 }
        END  { printf "Rata rata usia penumpang: %d tahun\n", total/(NR-1) }
        ' passenger.csv
        ;;
```

opsi d menghitung rata rata umur dengan menghitung total umur (total) dengan total penumpang (NR-1) karena header tidak terhitung

```bash
    "e")
        awk -F',' '
        NR>1 && $3=="Business" { total++ }
        END { print "Total penumpang Business Class: " total }
        ' passenger.csv
        ;;
```
opsi e menghitung total business class yang berada di kereta dengan $3=="Business" hanya mencari penumpang dengan kolum business

```bash
 *)
        echo "milih yang benerr WOIGHHHHHHHHHHH"
        ;;
esac
```
dan opsi selain a/b/c/d/e akan mengeluarkan echo seperti itu. esac untuk keluar dari case 

### Output
1. Unduh file data .csv
<img width="1479" height="735" alt="image" src="https://github.com/user-attachments/assets/17b97d4f-d234-4399-bd7a-e7ec65556a05" />

2. Output pilihan
<img width="998" height="638" alt="image" src="https://github.com/user-attachments/assets/9055ef80-f0bd-4242-99b4-b42a7205c91b" />



## Soal 2

### Penjelasan

langkah pertama adalah download peta-ekspedisi-amba.pdf dan simpan ke directory ekspedisi

dengan cat peta-ekspedisi-amba.pdf (concatenate), bisa dibedah isi file tersebut dan  akhirnya mendapatkan link https://github.com/pocongcyber77/peta-gunung-kawi.git dan akhirnya menemukan gsxtrack.json dan didownload, masukkan ke repo berisi data koordinat.

dari situ diminta untuk memasukkan informasi seperti id, site_name(x), latitude, longitude dimasukkan ke file titik-penting.txt menggunakan shell scripting dengan nama file parserkoordinat.sh

### Code

```bash
#!/bin/bash

INPUT="gsxtrack.json"
OUTPUT="titik-penting.txt"

echo "id,site_name,latitude,longitude" > "$OUTPUT"
```
mendeklarasi input dari data awal dan output ke titik-penting.txt
memasukan ``` id,site_name,latitude,longitude ``` kepada output untuk header

```bash
awk '
/"id":/ && /"node_/ {
    gsub(/.*"id": "/,""); gsub(/",.*/,""); id=$0
}
```
menggunakan awk untuk mencari id, gsub untuk menghapus/substitusi string "id: " dan menghapus apapun setelah koma, id=$0 artinya id mempunyai nilai apapun yang didapat dari line tersebut yang dibantu oleh awk

```bash
/"site_name":/ {
    gsub(/.*"site_name": "/,""); gsub(/",.*/,""); site=$0
}
/"latitude":/ {
    gsub(/.*"latitude": /,""); gsub(/,.*/,""); lat=$0
}
/"longitude":/ {
    gsub(/.*"longitude": /,""); gsub(/,.*/,""); lon=$0
    print id","site","lat","lon
```
logika yang sama untuk variabel lainnya, akhirnya akan di print dalam urutan id, site, lat, lon.

```bash
}' "$INPUT" >> "$OUTPUT"

echo "Selesai transfer woiiiighhhhhhhhhhhh"
```
output dari awk tersebut di transfer dari nilai %input ke %output
