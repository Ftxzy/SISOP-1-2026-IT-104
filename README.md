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
output dari awk tersebut di transfer dari nilai $input ke $output (direct)

### Penjelasan 2
diminta pada soal untuk menemukan titik tengah diagonal dengan rumus

<img width="269" height="82" alt="image" src="https://github.com/user-attachments/assets/3f04ae1e-48af-4579-b61f-d45635702f4a" />

dalam file nemupusaka.sh dan di output >> posisipusaka.txt (lat,lon)

### Code 2
```bash
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
```
dengan rumus yang didapat, kita boleh hanya membaca line 2 dan 4 karena id 1 dan 2 mempunyai lat sama, sedangkan 3 dan 4 mempunyai lon yang sama. kita bisa mendeklarasikan id dua dan empat menjadi x1 y1 dan x2 y2 
yang akhirnya akan di transfer outputnya ke posisipusaka.txt

### Output
1. unduh file pdf
<img width="1240" height="873" alt="image" src="https://github.com/user-attachments/assets/c3100207-3211-4c86-ad81-6df90c3df619" />

2. setelah concatenate file pdf mendapatkan link gsxtrack.json di github
<img width="1912" height="905" alt="image" src="https://github.com/user-attachments/assets/dc1f8276-25e6-4b5e-91b6-e65745fbf6d7" />

3. parserkoordinat.sh
<img width="1462" height="749" alt="image" src="https://github.com/user-attachments/assets/a049ce75-df23-4e97-b6e7-c924947f3d50" />

4. nemupusaka.sh
<img width="1440" height="682" alt="image" src="https://github.com/user-attachments/assets/992d8c6e-3051-47e8-960a-939f53f263dd" />


## Soal 3

### Penjelasan

Membuat CLI interaktif untuk pengurusan kos

### Code

```bash
#!/bin/bash

DATA_FILE="data/penghuni.csv"

# buat CSV kalau belum ada
if [ ! -f "$DATA_FILE" ]; then
    echo "nama,kamar,harga_sewa,tanggal_masuk,status" > "$DATA_FILE"
fi
```
membuat data file data/penghuni.csv. Jika belum ada maka akan dibuat.

```bash
tambah_penghuni() {
    clear
    echo "=============================================="
    echo "       TAMBAH PENGHUNI BARU"
    echo "=============================================="

    # nama
    while true; do
        echo -n "Nama lengkap : "
        read nama

        if [ -z "$nama" ]; then   # -z: kosong?
            echo "  [!] Nama tidak boleh kosong. Coba lagi."
        else
            break
        fi
    done

    # kamar
    while true; do
        echo -n "Nomor kamar  : "
        read kamar

        if ! [[ "$kamar" =~ ^[0-9]+$ ]]; then   # =~ pencocokan regex, ^[0-9]+$ = hanya angka, dari awal sampai akhir
            echo "  [!] Nomor kamar harus berupa angka. Coba lagi."
            continue
        fi

        duplikat=$(awk -F',' -v k="$kamar" 'NR>1 && $2==k {print $1}' "$DATA_FILE")   # -v: kirim var bash ke awk
        if [ -z "$duplikat" ]; then
            break
        fi
        echo "  [!] Kamar $kamar sudah ditempati oleh: $duplikat. Masukkan nomor lain."
        continue
    done

    # harga sewa
    while true; do
        echo -n "Harga sewa   : Rp "
        read harga_sewa

        if ! [[ "$harga_sewa" =~ ^[0-9]+$ ]] || [ "$harga_sewa" -le 0 ]; then
            echo "  [!] Harga sewa harus angka positif. Coba lagi."
            continue
        fi

        break
    done

    # tanggal masuk
    today=$(date +%Y-%m-%d)   # tanggal hari ini dari sistem

    while true; do
        echo -n "Tanggal masuk (YYYY-MM-DD) : "
        read tanggal_masuk

        if ! [[ "$tanggal_masuk" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
            echo "  [!] Format tanggal salah. Gunakan YYYY-MM-DD. Coba lagi."
            continue
        fi

        if ! date -d "$tanggal_masuk" &>/dev/null; then
            echo "  [!] Tanggal tidak valid. Coba lagi."
            continue
        fi

        if [[ "$tanggal_masuk" > "$today" ]]; then
            echo "  [!] Tanggal masuk tidak boleh di masa depan (maks: $today). Coba lagi."
            continue
        fi

        break
    done

    # status awal
    while true; do
        echo -n "Status awal [aktif/menunggak] : "
        read status

        if [ "$status" != "aktif" ] && [ "$status" != "menunggak" ]; then
            echo "  [!] Status harus 'aktif' atau 'menunggak'. Coba lagi."
            continue
        fi

        break
    done

    # simpan ke csv
    echo "$nama,$kamar,$harga_sewa,$tanggal_masuk,$status" >> "$DATA_FILE"
    echo -e "\n  [OK] Data penghuni '$nama' berhasil disimpan."
}
```
Tambah penghuni baru. Menambahkan penghuni dengan input Nama, Nomor kamar, Harga sewa, Tanggal masuk (YYYY-MM-DD) dan status (aktif/menunggak)
#### Notes:
- ``` if [ -z "$nama" ] ``` artinya -z adalah jika nilai ini 0 = true
- ```if ! [[ "$kamar" =~ ^[0-9]+$ ]];``` artinya =~ adalah regex match operator, mengetes apakah sisi kiri = sisi kanan regex, dan =~ hanya bisa dideklarasikan dalam ```[[]]``` double bracket. ```^[0-9]+$``` artinya merupakan pattern regex, ia mengambil string dari awal sampai akhir (awal ```^``` hingga ```$```) dengan logika mengambil semua angka 0-9 dengan berapapun digit dibelakangnya (```+```)
- ``` duplikat=$(awk -F',' -v k="$kamar" 'NR>1 && $2==k {print $1}' "$DATA_FILE")``` artinya -v adalah sebuah operator untuk mentransfer variabel bash kedalam awk (```k="$kamar"```)
- ```today=$(date +%Y-%m-%d)``` untuk mendapatkan nilai tanggal hari ini di dalam sistem menggunakan format specifier %Y-%m-%d karena yang diminta YYYY-MM-DD
- ```if ! date -d "$tanggal_masuk" &>/dev/null;``` untuk menghapus error dengan memasukkan tanggal yang salah



```bash
HISTORY_FILE="sampah/history_hapus.csv"

# buat folder sampah kalau belum ada
if [ ! -f "$HISTORY_FILE" ]; then
    mkdir -p sampah
    echo "nama,kamar,harga_sewa,tanggal_masuk,status,tanggal_hapus" > "$HISTORY_FILE"
fi

hapus_penghuni() {
    clear
    echo "=============================================="
    echo "       HAPUS PENGHUNI"
    echo "=============================================="

    echo -n "Nama penghuni yang ingin dihapus : "
    read nama_hapus

    # cari baris, skip header
    hasil=$(awk -F',' -v n="$nama_hapus" 'NR>1 && $1==n' "$DATA_FILE")

    if [ -z "$hasil" ]; then
        echo -e "\n  [!] Penghuni '$nama_hapus' tidak ditemukan."
        return
    fi

    # pindah ke history, tambah tgl hapus
    today=$(date +%Y-%m-%d)
    echo "$hasil" | awk -F',' -v tgl="$today" '{print $0","tgl}' >> "$HISTORY_FILE"

    # tulis ulang CSV, buang baris terhapus
    awk -F',' -v n="$nama_hapus" 'NR==1 || $1!=n' "$DATA_FILE" > tmpfile.csv && mv tmpfile.csv "$DATA_FILE"

    echo -e "\n  [OK] Data penghuni '$nama_hapus' berhasil dihapus dan dipindahkan ke history."
}
```
Hapus penghuni. menghapus penghuni dengan input nama, kemudian ditaruh ke file ```sampah/history_hapus.csv``` dengan tambahan tanggal dihapusnya dengan metode memindahkan penghuni yang akan dihapus ke history file terlebih dahulu. setelah itu, membuat ulang file data csv dengan pengecualian nama yang dihapus menggunakan metode rewrite ke file temporary dan overwrite yang di file temporary tersebut balik ke file utama data_file.

```bash
tampilkan_penghuni() {
    clear
    echo "=============================================="
    echo "       DAFTAR PENGHUNI"
    echo "=============================================="

    # cek ada data atau enggak
    if [ $(awk 'END {print NR}' "$DATA_FILE") -le 1 ]; then
        echo -e "\n  [!] Belum ada data penghuni."
        return
    fi

    awk -F',' '
    NR==1 { next }   # skip header
    {
        printf "  %-20s %-8s %-15s %-12s %s\n", $1, $2, $3, $4, $5
    }
    ' "$DATA_FILE"
}
```
Menampilkan penghuni. menggunakan printf agar bisa memakai format specifier seperti %-20s artinya 
- ```-``` merupakan alignment, dimana text yang akan dimunculkan nantinya di bagian kiri
- ```20``` merupakan berapa spasi yang akan diberikan
- ```s``` jenis yang di print (string)


```bash
update_status() {
    clear
    echo "=============================================="
    echo "       UPDATE STATUS PENGHUNI"
    echo "=============================================="

    echo -n "Nama penghuni : "
    read nama_update

    # cek penghuni ada atau enggak
    hasil=$(awk -F',' -v n="$nama_update" 'NR>1 && $1==n' "$DATA_FILE")
    if [ -z "$hasil" ]; then
        echo -e "\n  [!] Penghuni '$nama_update' tidak ditemukan."
        return
    fi

    # tampil status sekarang
    status_sekarang=$(awk -F',' -v n="$nama_update" 'NR>1 && $1==n {print $5}' "$DATA_FILE")
    echo -e "\n  Status sekarang : $status_sekarang"

    # input status baru
    while true; do
        echo -n "  Status baru [aktif/menunggak] : "
        read status_baru
        status_baru=$(echo "$status_baru" | tr '[:upper:]' '[:lower:]')

        if [ "$status_baru" != "aktif" ] && [ "$status_baru" != "menunggak" ]; then
            echo "  [!] Status harus 'aktif' atau 'menunggak'. Coba lagi."
            continue
        fi

        break
    done

    # OFS="," biar CSV ga rusak pas kolom diubah
    awk -F',' -v n="$nama_update" -v s="$status_baru" '
    BEGIN { OFS="," }
    NR==1 || $1!=n { print }
    $1==n { $5=s; print }
    ' "$DATA_FILE" > tmpfile.csv && mv tmpfile.csv "$DATA_FILE"

    echo -e "\n  [OK] Status '$nama_update' berhasil diubah ke '$status_baru'."
}
```
Mengupdate status penghuni. dengan formatting case sensitive di ```status_baru=$(echo "$status_baru" | tr '[:upper:]' '[:lower:]')``` yang akan mentranslatekan semua uppercase menjadi lowercase.
#### Notes:
- jika -F adalah format dengan cara bagaimana awk membaca dan memisah kolom sebuah file, format untuk outputnya merupakan OFS (output field seperator)
- cara mengubah status adalah dengan cara yang sama sebelumnya (tmpfile)

```bash
LAPORAN_FILE="rekap/laporan_bulanan.txt"

if [ ! -f "$LAPORAN_FILE" ]; then
    mkdir -p rekap
fi

laporan_keuangan() {
    clear

    # hitung total aktif dan menunggak
    awk -F',' '
    NR>1 {
        if ($5 == "aktif") total_aktif += $3
        else if ($5 == "menunggak") total_menunggak += $3
    }
    END {
        print "=============================================="
        print "  LAPORAN KEUANGAN KOS"
        print "=============================================="
        print "  Total pemasukan (aktif)    : Rp " total_aktif
        print "  Total menunggak            : Rp " total_menunggak
        print "=============================================="
    }
    ' "$DATA_FILE" | tee "$LAPORAN_FILE"   # tee: cetak + simpan sekaligus

    echo -e "\n  [OK] Laporan disimpan ke $LAPORAN_FILE."
```
Laporan keuangan, dipisahkan dari yang aktif dan menunggak
#### Notes:
- tee = meng Output ke terminal dan simpan ke laporan_file

### Cron Job

```bash
SCRIPT_PATH=$(realpath "$0")   # cron butuh path absolut
CRON_TAG="# dorm-tagihan-reminder"   # tag penanda cron job kita
```
- realpath $0 agar cron mengetahui path absolut dari script yang kita pakai
- cron_tag agar cron script ini mempunyai tanda spesifik dan tidak tercampur oleh cron lainnya


```bash
if [ "$1" = "--check-tagihan" ]; then
    LOG_DIR="$(dirname "$(realpath "$0")")/log"
    LOG_FILE="$LOG_DIR/tagihan.log"
    mkdir -p "$LOG_DIR"

    TIMESTAMP=$(date "+%Y-%m-%d %H:%M")

    awk -F',' -v ts="$TIMESTAMP" '
    NR>1 && $5=="menunggak" {
        printf "[%s] %s | Kamar %s | Rp %s | menunggak\n", ts, $1, $2, $3
    }
    ' "$DATA_FILE" >> "$LOG_FILE"

    exit 0
fi
```

if statement untuk handler argumen ```--check-tagihan``` agar membuat file tagihan.log untuk penghuni menunggak


```bash
kelola_cron() {
    while true; do
        clear
        echo "=============================================="
        echo "       KELOLA CRON (PENGINGAT TAGIHAN)"
        echo "=============================================="
        echo "  1. Lihat jadwal aktif"
        echo "  2. Daftarkan jadwal baru"
        echo "  3. Hapus jadwal"
        echo "  4. Kembali ke menu utama"
        echo "=============================================="
        echo -n "  Pilih [1-4] : "
        read pilihan_cron
```
menu cron tersendiri


```bash
 case $pilihan_cron in
            1)
                jadwal_aktif=$(crontab -l 2>/dev/null | awk "/$CRON_TAG/")   # crontab -l: list semua cron, 2>/dev/null: buang error
                if [ -z "$jadwal_aktif" ]; then
                    echo -e "\n  [!] Tidak ada jadwal aktif."
                else
                    echo -e "\n  Jadwal aktif:"
                    echo "  $jadwal_aktif"
                fi
                ;;
```
Melihat daftar jadwal aktif. jadwal_aktif akan mengambil nilai dari list dengan cara
```(crontab -l 2>/dev/null | awk "/$CRON_TAG/")```
- crontab -l = mengeluarkan list crontab
- 2>/dev/null = membuang stderr/ buang error ke null. agar terminal lebih terlihat rapi
- | awk "/$CRON_TAG/" = piping ke awk yang hanya akan membaca cron dengan tanda tag yang kita buat


```bash
2)
                # input jam
                while true; do
                    echo -n "  Jam (00-23, default 07) : "
                    read input_jam
                    input_jam=${input_jam:-07}   # default 07 kalau kosong

                    if ! [[ "$input_jam" =~ ^[0-9]{1,2}$ ]] || [ "$input_jam" -lt 0 ] || [ "$input_jam" -gt 23 ]; then
                        echo "  [!] Jam harus antara 00-23. Coba lagi."
                        continue
                    fi
                    break
                done

                # input menit
                while true; do
                    echo -n "  Menit (00-59, default 00) : "
                    read input_menit
                    input_menit=${input_menit:-00}   # default 00 kalau kosong

                    if ! [[ "$input_menit" =~ ^[0-9]{1,2}$ ]] || [ "$input_menit" -lt 0 ] || [ "$input_menit" -gt 59 ]; then
                        echo "  [!] Menit harus antara 00-59. Coba lagi."
                        continue
                    fi
                    break
                done

                # rakit string cron
                LOG_PATH="$(dirname "$SCRIPT_PATH")/log/tagihan.log"
                CRON_JOB="$input_menit $input_jam * * * $SCRIPT_PATH --check-tagihan >> $LOG_PATH $CRON_TAG"

                # hapus jadwal lama, overwrite baru
                (crontab -l 2>/dev/null | awk "!/$CRON_TAG/"; echo "$CRON_JOB") | crontab -

                echo -e "\n  [OK] Jadwal berhasil didaftarkan: setiap hari jam $input_jam:$input_menit."
                ;;
```
Menginput waktu cron dari user input dengan syarat default jam 07.00 WIB. dengan format cron *(menit) *(jam) *(hari) *(bulan) *(weekday).
Juga mampu overwrite dan menghapus cron sebelumnya yang ada, agar cron job hanya 1 dengan cara ```crontab -``` yang berarti baca dari stdin sebelumnya, dan gantikan semua yang ada disitu menjadi crontab yang baru ini


```bash
 3)
                if [ -z "$jadwal_aktif" ]; then
                    jadwal_aktif=$(crontab -l 2>/dev/null | awk "/$CRON_TAG/")
                fi
                if [ -z "$jadwal_aktif" ]; then
                    echo -e "\n  [!] Tidak ada jadwal aktif untuk dihapus."
                else
                    crontab -l 2>/dev/null | awk "!/$CRON_TAG/" | crontab -
                    echo -e "\n  [OK] Jadwal berhasil dihapus."
                fi
                ;;
```
Opsi terakhir menghapus jadwal cron, dengan cara sebelumnya (```crontab - ```)


```bash
 4)
                break   # balik ke menu utama
                ;;
            *)
                echo -e "\n  [!] Pilihan tidak valid."
                ;;
        esac

        echo -e "\nTekan [Enter] untuk melanjutkan..."
        read
    done
}
```
pilihan break dan opsi tidak valid

#### Main menu
```bash
while true; do
    clear
    echo "=============================================="
    echo "       SISTEM MANAJEMEN KOS"
    echo "=============================================="
    echo "  1. Tambah Penghuni Baru"
    echo "  2. Hapus Penghuni"
    echo "  3. Tampilkan Daftar Penghuni"
    echo "  4. Update Status Penghuni"
    echo "  5. Cetak Laporan Keuangan"
    echo "  6. Kelola Cron (Pengingat Tagihan)"
    echo "  7. Keluar"
    echo "=============================================="
    echo -n "  Pilih menu [1-7] : "
    read pilihan

    case $pilihan in
        1) tambah_penghuni ;;
        2) hapus_penghuni ;;
        3) tampilkan_penghuni ;;
        4) update_status ;;
        5) laporan_keuangan ;;
        6) kelola_cron ;;
        7)
            clear
            echo "=============================================="
            echo "  Terima kasih. Sampai jumpa!"
            echo "=============================================="
            exit 0
            ;;
        *)
            echo -e "\n  [!] Pilihan tidak valid. Masukkan angka 1-7."
            ;;
    esac

    echo -e "\nTekan [Enter] untuk kembali ke menu..."
    read
done
```

### Output
1. Main Menu
<img width="682" height="342" alt="image" src="https://github.com/user-attachments/assets/c682e9d2-4f32-4c96-974a-9c317364b2b9" />


2. Tambah Penghuni Baru
<img width="675" height="295" alt="image" src="https://github.com/user-attachments/assets/6af055cd-d587-4ced-b2c9-1ddd94d36c1d" />
<img width="662" height="315" alt="image" src="https://github.com/user-attachments/assets/f77e752b-723e-442f-88cb-36fafce5191f" />

3. Hapus penghuni
<img width="975" height="317" alt="image" src="https://github.com/user-attachments/assets/2b0ef893-7d0f-4086-867c-606cfc148731" />
<img width="907" height="321" alt="image" src="https://github.com/user-attachments/assets/75912ab1-8db1-4071-ab20-34ee7a6d9de7" />



4. Tampilkan daftar penghuni
<img width="880" height="289" alt="image" src="https://github.com/user-attachments/assets/a8a68301-b372-46fc-a508-ba0125c0651b" />

5. Update status
<img width="709" height="345" alt="image" src="https://github.com/user-attachments/assets/7fd21d27-a57e-4e86-8996-361833bf4500" />
<img width="680" height="198" alt="image" src="https://github.com/user-attachments/assets/dd15bd63-958b-4a56-aae2-82eb92428b38" />

6. Cetak laporan keuangan
<img width="856" height="310" alt="image" src="https://github.com/user-attachments/assets/5e0f19c5-cdc2-4631-9cf2-f6a038db12f4" />
<img width="810" height="334" alt="image" src="https://github.com/user-attachments/assets/686845c6-bc2f-47b8-9535-6918c3d44564" />


7. CRON
<img width="646" height="270" alt="image" src="https://github.com/user-attachments/assets/4b111831-305d-4fd7-84fa-1394a033219c" />


Lihat Jadwal aktif
<img width="1032" height="251" alt="image" src="https://github.com/user-attachments/assets/80e4e197-c271-4d46-bbcb-e9788c68400a" />


Daftar jadwal baru
<img width="875" height="424" alt="image" src="https://github.com/user-attachments/assets/9db3269a-3758-41a4-ac23-b1462abc4a92" />


Hapus Jadwal
<img width="828" height="438" alt="image" src="https://github.com/user-attachments/assets/0da87bfe-aeaf-4fde-a3d7-227a9fd137fc" />


Tagihan Log
<img width="1005" height="387" alt="image" src="https://github.com/user-attachments/assets/8ab37fa4-0fe3-4b8f-b248-8bda7041de4f" />









