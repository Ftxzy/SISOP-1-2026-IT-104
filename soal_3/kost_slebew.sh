#!/bin/bash

DATA_FILE="data/penghuni.csv"

# buat CSV kalau belum ada
if [ ! -f "$DATA_FILE" ]; then
    echo "nama,kamar,harga_sewa,tanggal_masuk,status" > "$DATA_FILE"
fi

# tambah penghuni baru

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

# hapus penghuni

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

# tampilkan daftar penghuni

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

# update status penghuni

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

# cetak laporan keuangan

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
}

# kelola cron

SCRIPT_PATH=$(realpath "$0")   # cron butuh path absolut
CRON_TAG="# dorm-tagihan-reminder"   # tag penanda cron job kita

# handler --check-tagihan, dipanggil cron
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

# main menu

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
