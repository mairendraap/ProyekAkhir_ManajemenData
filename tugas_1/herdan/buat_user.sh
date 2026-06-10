```bash
   #!/bin/bash

   # Pastikan script dijalankan sebagai root/sudo
   if [ "$EUID" -ne 0 ]; then
     echo "Harap jalankan script ini dengan sudo!"
     exit 1
   fi

   FILE="users.txt"

   if [ ! -f "$FILE" ]; then
     echo "File $FILE tidak ditemukan!"
     exit 1
   fi

   while IFS= read -r username || [ -n "$username" ]; do
     # Menghapus spasi atau karakter newline yang tidak diinginkan
     username=$(echo "$username" | tr -d '\r' | xargs)
    if [ -z "$username" ]; then
       continue
     fi

     # Cek apakah user sudah ada
     if id "$username" &>/dev/null; then
       echo "User '$username' sudah ada."
     else
       # Set password format: namauser@123
       password="${username}@123"
       # Buat user baru dengan home direktori dan shell bash
       useradd -m -s /bin/bash "$username"
       # Set password secara otomatis
       echo "${username}:${password}" | chpasswd
       echo "User '$username' berhasil dibuat dengan password: $password"
     fi
   done < "$FILE"
