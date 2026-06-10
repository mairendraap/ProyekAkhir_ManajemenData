#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "run with sudo!"
  exit 1
fi

read -p "Masukkan banyaknya user yang mau dibuat: " jumlah_user

if [[ ! "$jumlah_user" =~ ^[0-9]+$ ]]; then
   echo "Error: Jumlah user harus berupa angka!"
   exit 1
fi

for ((i=1; i<=jumlah_user; i++))
do
    echo "-----------------------------------"
    echo "Menginput data untuk User ke-$i:"
    read -p "  Nama user: " username
    if id "$username" &>/dev/null; then
        echo "'$username' sudah ada jadi saya skip."
        continue
    fi
    read -s -p "  Password user: " password
    echo ""
    useradd -m -s /bin/bash "$username"
    echo "$username:$password" | chpasswd
    if [ $? -eq 0 ]; then
        echo "'$username' berhasil dibuat."
    else
        echo "gagal membuat user '$username'."
    fi
done

echo "done!"
