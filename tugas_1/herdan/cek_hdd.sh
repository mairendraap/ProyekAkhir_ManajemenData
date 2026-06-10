#!/bin/bash

# 1. Mengambil persentase ruang yang digunakan pada partisi root (/)
# Menggunakan awk secara clean tanpa backtick lama
KAPASITAS_TERPAKAI=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

# 2. Menghitung sisa space HDD (100 - Terpakai)
SISA_SPACE=$((100 - KAPASITAS_TERPAKAI))

# 3. Menampilkan hasil output ke terminal
echo "======================================"
echo "       NOTIFIKASI SISTEM MONITORING   "
echo "======================================"
echo "Pemberitahuan: Space HDD Anda tinggal $SISA_SPACE%"
echo "======================================"

# 4. Memberikan peringatan tambahan jika space kritis di bawah 20%
if [ "$SISA_SPACE" -lt 20 ]; then
    echo "PERINGATAN: Kapasitas harddisk hampir habis!"
fi
