```markdown
# Laporan Praktikum Manajemen Data - Proyek Akhir

Sistem Manajemen Data dan Infrastruktur Server berbasis **WSL2 (Ubuntu)**, **Python Flask**, dan **Nginx Web Server** yang dideploy menggunakan **Docker Container**. [cite_start]Proyek ini ditujukan untuk memenuhi penilaian Proyek Akhir mata kuliah Praktikum Manajemen Data[cite: 1, 2, 7].

## 👤 Identitas Mahasiswa
* [cite_start]**Nama:** Herdan Wahyu Mairendra Pangestu [cite: 4]
* [cite_start]**NRP:** 3325600064 [cite: 5]
* [cite_start]**Program Studi:** STR Sains Data Terapan [cite: 7]
* [cite_start]**Institusi:** Politeknik Elektronika Negeri Surabaya [cite: 7]
* [cite_start]**Tahun:** 2026 [cite: 7]

---

## 📁 Struktur Direktori Proyek
```text
.
├── Tugas-1/
│   ├── buat_user.sh
│   ├── cek_hdd.sh
│   └── users.txt
└── Tugas-2/
    ├── nginx/
    │   ├── Dockerfile
    │   └── nginx.conf
    ├── app.py
    ├── Dockerfile
    └── requirements.txt

```

---

## 🐧 Tugas 1: Administrasi Sistem & Scripting (WSL)

Bagian ini berfokus pada otomatisasi administrasi server Linux menggunakan Bash Scripting di dalam lingkungan WSL.

### 1. Otomatisasi Pembuatan User Baru (`buat_user.sh`)

Script ini berfungsi untuk membaca daftar nama dari berkas `users.txt` dan membuat user sistem secara massal beserta *default password* secara otomatis.

* **Sintaks Script (`buat_user.sh`):**
```bash
#!/bin/bash
if [ "$(id -u)" -ne 0 ]; then
   echo "Harap jalankan script ini dengan sudo!"
   exit 1
fi

FILE="users.txt"
if [ ! -f "$FILE" ]; then
   echo "File $FILE tidak ditemukan!"
   exit 1
fi

while IFS= read -r username || [ -n "$username" ]; do
   username=$(echo "$username" | tr -d '\r' | xargs)
   if [ -z "$username" ]; then 
       continue
   fi

   if getent passwd "$username" > /dev/null 2>&1; then
       echo "User '$username' sudah ada."
   else
       password="${username}@123"
       useradd -m -s /bin/bash "$username"
       echo "${username}:${password}" | chpasswd
       echo "User '$username' berhasil dibuat dengan password: $password"
   fi
done < "$FILE"
[cite_start]

```



---

## 🚀 Cara Menjalankan Aplikasi

1. Pastikan Anda berada di dalam direktori `Tugas-2/` via PowerShell atau Terminal WSL.


2. Eksekusi perintah berikut untuk membangun dan menghidupkan seluruh layanan secara *detached mode*:
```powershell
docker compose up -d --build --force-recreate
[cite_start]

```

Berikut adalah draf file `README.md` yang disusun secara lengkap, sistematis, dan profesional berdasarkan seluruh *source code* serta hasil eksekusi yang tercantum di dalam laporan praktikummu.

Kamu bisa langsung menyalin (*copy*) seluruh teks di dalam kotak kode bawah ini untuk dijadikan berkas `README.md` di repositori GitHub milikmu.

---

Berikut adalah draf file `README.md` yang disusun secara lengkap, sistematis, dan profesional berdasarkan seluruh *source code* serta hasil eksekusi yang tercantum di dalam laporan praktikummu.

Kamu bisa langsung menyalin (*copy*) seluruh teks di dalam kotak kode bawah ini untuk dijadikan berkas `README.md` di repositori GitHub milikmu.

---

```markdown
# Laporan Praktikum Manajemen Data - Proyek Akhir

Sistem Manajemen Data dan Infrastruktur Server berbasis **WSL2 (Ubuntu)**, **Python Flask**, dan **Nginx Web Server** yang dideploy menggunakan **Docker Container**. [cite_start]Proyek ini ditujukan untuk memenuhi penilaian Proyek Akhir mata kuliah Praktikum Manajemen Data[cite: 1, 2, 7].

## 👤 Identitas Mahasiswa
* [cite_start]**Nama:** Herdan Wahyu Mairendra Pangestu [cite: 4]
* [cite_start]**NRP:** 3325600064 [cite: 5]
* [cite_start]**Program Studi:** STR Sains Data Terapan [cite: 7]
* [cite_start]**Institusi:** Politeknik Elektronika Negeri Surabaya [cite: 7]
* [cite_start]**Tahun:** 2026 [cite: 7]

---

## 📁 Struktur Direktori Proyek
```text
.
├── Tugas-1/
│   ├── buat_user.sh
│   ├── cek_hdd.sh
│   └── users.txt
└── Tugas-2/
    ├── nginx/
    │   ├── Dockerfile
    │   └── nginx.conf
    ├── app.py
    ├── Dockerfile
    └── requirements.txt

```

---

## 🐧 Tugas 1: Administrasi Sistem & Scripting (WSL)

Bagian ini berfokus pada otomatisasi administrasi server Linux menggunakan Bash Scripting di dalam lingkungan WSL.

### 1. Otomatisasi Pembuatan User Baru (`buat_user.sh`)

Script ini berfungsi untuk membaca daftar nama dari berkas `users.txt` dan membuat user sistem secara massal beserta *default password* secara otomatis.

* **Sintaks Script (`buat_user.sh`):**
```bash
#!/bin/bash
if [ "$(id -u)" -ne 0 ]; then
   echo "Harap jalankan script ini dengan sudo!"
   exit 1
fi

FILE="users.txt"
if [ ! -f "$FILE" ]; then
   echo "File $FILE tidak ditemukan!"
   exit 1
fi

while IFS= read -r username || [ -n "$username" ]; do
   username=$(echo "$username" | tr -d '\r' | xargs)
   if [ -z "$username" ]; then 
       continue
   fi

   if getent passwd "$username" > /dev/null 2>&1; then
       echo "User '$username' sudah ada."
   else
       password="${username}@123"
       useradd -m -s /bin/bash "$username"
       echo "${username}:${password}" | chpasswd
       echo "User '$username' berhasil dibuat dengan password: $password"
   fi
done < "$FILE"
[cite_start]

```



---

## 🚀 Cara Menjalankan Aplikasi

1. Pastikan Anda berada di dalam direktori `Tugas-2/` via PowerShell atau Terminal WSL.


2. Eksekusi perintah berikut untuk membangun dan menghidupkan seluruh layanan secara *detached mode*:
```powershell
docker compose up -d --build --force-recreate
[cite_start]

```

```


