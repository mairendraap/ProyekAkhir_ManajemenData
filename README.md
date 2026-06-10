
## TUGAS 1: ADMINISTRASI SISTEM & SCRIPTING (WSL)

### 1. Script Pembuatan User Otomatis (`buat_user.sh`)

#### **A. Penjelasan Kode**

Di dalam file ini, terdapat logika otomasi administrasi user Linux:

* 
**`if [ "$(id -u)" -ne 0 ]; then ... fi`**: Baris ini bertindak sebagai gerbang keamanan. Script memeriksa apakah ID user yang menjalankan perintah ini bernilai `0` (Root/Sudo). Jika tidak (`-ne` atau *not equal*), script akan berhenti dan memunculkan peringatan.


* 
**`FILE="users.txt"`**: Mendefinisikan nama file sumber yang menampung daftar nama user.


* 
**`while IFS= read -r username ... do ... done < "$FILE"`**: Perulangan (*looping*) untuk membaca baris demi baris nama di dalam file `users.txt`.


* 
**`username=$(echo "$username" | tr -d '\r' | xargs)`**: Ini adalah perintah pembersihan teks. `tr -d '\r'` bertugas membuang sisa karakter format Windows (CRLF) agar script tidak mengalami error *Syntax error: EOF* saat dieksekusi di Linux/WSL , sedangkan `xargs` membuang spasi kosong di awal/akhir nama.


* 
**`if getent passwd "$username" ...`**: Memeriksa ke dalam sistem Linux apakah nama user tersebut sudah terdaftar atau belum. Jika sudah ada, sistem hanya mencetak pesan `"User sudah ada"`.


* 
**`useradd -m -s /bin/bash "$username"`**: Jika belum ada, perintah ini akan mengeksekusi pembuatan user baru secara otomatis. Argumen `-m` berfungsi membuatkan folder Home otomatis (misal: `/home/budi`), dan `-s /bin/bash` memberikan akses terminal Bash standar.


* 
**`echo "${username}:${password}" | chpasswd`**: Mengatur password user baru tersebut secara otomatis dengan format `namauser@123`.



#### **B. Analisis Perbaikan Output Laporan**

Berdasarkan log di laporan halaman 2, kamu sempat mengalami beberapa kali error sebelum akhirnya sukses:

* 
**Error Awal (`Syntax error: EOF in backquote substitution`)**: Ini terjadi karena file script kamu mengandung karakter penanda baris Windows (`\r`). Setelah dibersihkan (atau ditulis ulang lewat file `create_user.sh`), script berhasil berjalan.


* **Output Sukses Akhir**:
```text
User 'budi' berhasil dibuat dengan password: budi@123
User 'andi' berhasil dibuat dengan password: andi@123
User 'cici' berhasil dibuat dengan password: cici@123

```


Sistem sukses membacakan isi `users.txt` dan mendaftarkan user Budi, Andi, dan Cici ke dalam server WSL Linux kamu.



---

### ### 2. Pembuatan Disk Virtual & Manajemen Backup (`crontab`)

#### **A. Penjelasan Kode Penjadwalan**

Kamu membuat sebuah disk virtual eksternal berbasis file sebesar 50 MB menggunakan perintah `dd if=/dev/zero of=...` , memformatnya ke sistem file Linux (`mkfs.ext4`) , lalu menempelkannya (*mount*) ke direktori `/mnt/data_baru`.

Untuk mengotomatiskan pencadangan data dari disk tersebut ke folder `/backup`, kamu menggunakan **Cron Job** dengan sintaks berikut:

1. 
**`30 11 9 * * tar -czf /backup/backup_tgl9...`** 


* 
`30 11`: Perintah dijalankan tepat pada menit ke-30 dan jam 11 siang (11:30).


* 
`9`: Dijalankan hanya pada tanggal 9 setiap bulannya.


* 
`* *`: Berlaku untuk semua bulan dan semua hari dalam seminggu.




2. 
**`50 11 * * 4 tar -czf /backup/backup_kamis...`** 


* 
`50 11`: Perintah dijalankan tepat pada menit ke-50 dan jam 11 siang (11:50).


* 
`* * 4`: Mengabaikan tanggal dan bulan, tetapi wajib dijalankan setiap hari **Kamis** (angka 4 dalam Linux cron melambangkan hari Kamis).


* 
**`tar -czf`**: Mengompresi seluruh data yang ada di dalam folder `/mnt/disk_baru` menjadi sebuah file arsip `.tar.gz` yang dilengkapi dengan nama dinamis berupa tanggal dan jam eksekusi (`$(date +%Y%m%d...)`).





#### **B. Penjelasan Output**

* Ketika kamu mengecek isi direktori backup menggunakan perintah `ls -lh /backup` , file hasil kompresi berhasil terbentuk:


```text
-rw-r--r-- 1 root root 146 Jun 9 21:33 backup_kamis.tar.gz

```


* Saat file tersebut diuji ekstraksi menggunakan perintah `tar -xzvf` ke folder `~/hasil_extract` , seluruh struktur folder `/mnt/data_baru/` berhasil dikembalikan dengan utuh dan selamat.



---

### ### 3. Script Monitoring Space HDD (`cek_hdd.sh`)

#### **A. Penjelasan Kode**

* 
**`KAPASITAS_TERPAKAI=$(df / | grep -E '/$' | awk '{print $5}' | tr -cd '0-9')`**: Perintah berantai (*piping*) yang sangat cerdas. `df /` mengambil data penggunaan partisi root. `grep` menyaring baris ujung, `awk '{print $5}'` mengambil kolom persentase (misal muncul `1%`), dan `tr -cd '0-9'` membuang simbol `%` sehingga menyisakan angka murninya saja (`1`).


* 
**`SISA_SPACE=$((100 - KAPASITAS_TERPAKAI))`**: Rumus matematika untuk menghitung sisa ruang penyimpanan bersih laptop kamu.


* 
**`if [ "$SISA_SPACE" -lt 20 ]; then ... fi`**: Menguji kondisi penyimpanan. Jika sisa ruang penyimpanan lebih kecil (`-lt` atau *less than*) dari 20%, terminal akan otomatis menyemburkan teks peringatan bahaya.



#### **B. Penjelasan Output**

Saat dijalankan menggunakan perintah `sudo ./cek_hdd.sh` , terminal memunculkan hasil perhitungan data manajemen berikut:

```text
======================================
     NOTIFIKASI SISTEM MONITORING     
======================================
Pemberitahuan: Space HDD Anda tinggal 99%
======================================

```

Karena angka 99% jauh lebih besar dari batas kritis 20%, script tidak mengeluarkan teks peringatan bahaya, menandakan penyimpanan server kamu masih sangat lega.

---

## ## 🐳 TUGAS 2: DEPLOYMENT CONTAINER (DOCKER & NGINX PROXY)

Pada Tugas 2, arsitektur manajemen data ditingkatkan menjadi sistem web server multi-container menggunakan **Docker Compose**.

### ### 1. Dockerfile Utama (Aplikasi Python Flask)

#### **A. Penjelasan Kode**

```dockerfile
FROM python:3.10-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python", "app.py"]

```

* 
**`FROM python:3.10-slim`**: Mengunduh base image Python resmi versi 3.10 yang berukuran sangat kecil (*slim*) agar menghemat RAM laptop.


* 
**`WORKDIR /app`**: Membuat folder kerja internal di dalam sistem kontainer bernama `/app`.


* 
**`RUN pip install ...`**: Menginstalkan seluruh library Python yang terdaftar di file `requirements.txt` (yaitu library `flask`) ke dalam container.


* **`EXPOSE 5000`**: Membuka jalur komunikasi data internal container pada port 5000 (port bawaan Flask).
* **`CMD ["python", "app.py"]`**: Instruksi utama untuk menyalakan web Flask secara otomatis begitu container aktif.

---

### ### 2. Source Code Analisis Data (`app.py`)

#### **A. Penjelasan Kode**

File ini murni melakukan proses **Analisis Manajemen Data** terhadap aset industri kilang minyak (*Oil & Gas*).

* 
**`raw_data = [...]`**: Kumpulan dataset mentah berformat array multidimensi berisi log operasional harian 5 unit rig pengeboran.


* **Proses Analisis Deskriptif**:
* Menghitung total volume produksi lapangan minyak dengan menjumlahkan kolom indeks ke-1 (`sum(row[1])`).


* Menghitung rata-rata downtime mekanis pipa pengeboran dengan membagi total downtime terhadap jumlah unit rig.


* Menghitung rata-rata tekanan kompresor pompa gas dalam satuan PSI.




* 
**Deteksi Anomali Risiko**: Menggunakan teknik *list comprehension* untuk menyaring otomatis rig mana saja yang memiliki waktu henti pompa berbahaya di atas 3 jam (`row[2] > 3.0`).


* 
**`return html`**: Mengompilasi seluruh angka hasil analisis data statistik tadi ke dalam visualisasi dashboard web HTML dan CSS yang scannable.



---

### ### 3. File Orkestrasi `docker-compose.yml`

#### **A. Penjelasan Kode**

```yaml
version: '3.8'

services:
  flask-app:
    build: .
    container_name: flask-analysis-container
    restart: always
    expose:
      - "5000"

  nginx:
    build: ./nginx
    container_name: nginx-proxy-container
    restart: always
    ports:
      - "80:80"
    depends_on:
      - flask-app

```

* 
**`services:`**: Mendaftarkan dua buah layanan kontainer terpisah, yaitu `flask-app` (aplikasi pengolah data) dan `nginx` (web server gerbang depan).


* 
**`ports: - "80:80"`**: Mengunci port fisik laptop Windows kamu di port web standar (**Port 80**) untuk langsung disambungkan ke port 80 milik container Nginx.


* **`depends_on: - flask-app`**: Mengatur urutan peluncuran. Nginx diperintahkan untuk menunggu sampai container Flask benar-benar menyala dan siap beroperasi terlebih dahulu, baru Nginx boleh aktif membuka gerbang jaringan.

---

### ### 4. Penjelasan Log Output Sukses Akhir (Klimaks Laporan)

Berdasarkan screenshot terminal PowerShell halaman 11 dan rekaman log kontainer halaman 12, arsitektur kamu berjalan dengan performa terbaik:

1. 
**Log Status Container (`docker compose ps`)**:


```text
NAME                       IMAGE            STATUS
flask-analysis-container   docker-flask-app Up About a minute
nginx-proxy-container      docker-nginx     Up About a minute

```


Kedua container sukses berstatus **Up (Running)** bersamaan secara stabil tanpa mengalami crash berulang.


2. 
**Log Trafik Akses Nginx (Halaman 12)**:


```text
172.18.0.1 - - [10/Jun/2026:06:39:25 +0000] "GET / HTTP/1.1" 200 5105

```


Ketika kamu mengetik alamat `http://localhost` di browser Windows kamu , Nginx berhasil menangkap permintaan tersebut dan melemparkannya ke Flask. Kode status **`200`** menandakan pengiriman data visualisasi dashboard sukses total tanpa hambatan!


3. 
**Hasil Dashboard Analisis Tampilan Web**:


* 
**Total Lapangan:** Berhasil terhitung sebesar **53,200 BBL** minyak bumi.


* 
**Rata-rata Downtime:** Terdeteksi sebesar **2.80 Jam**.


* 
**Metrik Tekanan:** Berada di nilai **2962.0 PSI**.


* 
**Kotak Manajemen Risiko:** Otomatis memicu alarm peringatan warna kuning karena mendeteksi adanya dua unit rig anomali yang kritis, yaitu **Rig-Beta** dan **Rig-Delta**.
