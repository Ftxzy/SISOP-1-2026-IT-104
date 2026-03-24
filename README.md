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
