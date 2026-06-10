#!/bin/bash

# Path file log dan laporan
LOG_FILE="/var/log/user_activity.log"
REPORT_FILE="/var/log/daily_report.txt"
ALERT_FILE="/var/log/alert.log"

# 1. Menangani error jika file log tidak ada atau kosong
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File log tidak ditemukan di $LOG_FILE"
    exit 1
elif [ ! -s "$LOG_FILE" ]; then
    echo "Error: File log di $LOG_FILE kosong"
    exit 1
fi

# 2. Mendapatkan tanggal hari ini (Format: YYYY-MM-DD)
TODAY=$(date +%Y-%m-%d)
# Simpan waktu lengkap saat ini untuk kebutuhan log alert
CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")

# Ekstrak semua baris log dari hari ini saja ke dalam variabel/temporary data
TODAY_LOG=$(grep "^$TODAY" "$LOG_FILE")

# Jika tidak ada aktivitas sama sekali hari ini
if [ -z "$TODAY_LOG" ]; then
    echo "Tidak ada aktivitas log untuk hari ini ($TODAY)."
    exit 0
fi

# 3. Menghitung Total Percobaan Login Gagal
# Filter: ACTION=login dan STATUS=FAILED
FAILED_LOGIN=$(echo "$TODAY_LOG" | grep "ACTION=login" | grep "STATUS=FAILED" | wc -l)

# 4. Menghitung Total Upload Sukses
# Filter: ACTION=upload dan STATUS=SUCCESS
SUCCESS_UPLOAD=$(echo "$TODAY_LOG" | grep "ACTION=upload" | grep "STATUS=SUCCESS" | wc -l)

# 5. Menyusun format laporan dan menyimpannya ke /var/log/daily_report.txt
{
    echo "======================================"
    echo "DAILY ACTIVITY REPORT"
    echo "Tanggal: $TODAY"
    echo "======================================"
    echo "Total login gagal: $FAILED_LOGIN"
    echo "Total upload sukses: $SUCCESS_UPLOAD"
    echo "Top 3 user paling aktif:"
    
    # Mencari 3 user paling aktif:
    # - Ambil bagian USER=... menggunakan awk dengan pemisah '|'
    # - Potong kata 'USER=' menggunakan sed agar menyisakan nama user saja
    # - Urutkan (sort), hitung keunikan jumlahnya (uniq -c), urutkan secara descending (sort -nr), ambil 3 teratas (head -n 3)
    # - Format keluaran menjadi "X. username - Y aktivitas"
    echo "$TODAY_LOG" | awk -F '|' '{print $2}' | sed 's/ USER=//g' | sort | uniq -c | sort -nr | head -n 3 | \
    awk '{print NR". "$2" - "$1" aktivitas"}'
    
    echo "======================================"
} > "$REPORT_FILE"

# 6. Mengirim/menulis peringatan (alert) jika login gagal > 10 kali
if [ "$FAILED_LOGIN" -gt 10 ]; then
    echo "[$CURRENT_TIME] ALERT: Terjadi $FAILED_LOGIN kali login gagal hari ini!" >> "$ALERT_FILE"
fi

echo "Proses analisis selesai. Laporan telah disimpan di $REPORT_FILE"
