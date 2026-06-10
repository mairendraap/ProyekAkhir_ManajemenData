#!/bin/bash

# 1. Pastikan script dijalankan sebagai root/sudo
if [ "$(id -u)" -ne 0 ]; then
  echo "Harap jalankan script ini dengan sudo!"
  exit 1
fi

FILE="users.txt"

# 2. Cek apakah file users.txt ada
if [ ! -f "$FILE" ]; then
  echo "File $FILE tidak ditemukan!"
  exit 1
fi

# 3. Proses membaca file dan membuat user
while IFS= read -r username || [ -n "$username" ]; do
  # Menghapus spasi tersembunyi atau karakter Windows carriage return (\r)
  username=$(echo "$username" | tr -d '\r' | xargs)
  
  # Lewati jika baris kosong
  if [ -z "$username" ]; then
    continue
  fi

  # Cek apakah user sudah terdaftar di /etc/passwd
  if getent passwd "$username" > /dev/null 2>&1; then
    echo "User '$username' sudah ada."
  else
    # Format password otomatis: namauser@123
    password="${username}@123"
    
    # Buat user baru dengan home folder dan shell default bash
    useradd -m -s /bin/bash "$username"
    
    # Set password secara otomatis
    echo "${username}:${password}" | chpasswd
    
    echo "User '$username' berhasil dibuat dengan password: $password"
  fi
done < "$FILE"
