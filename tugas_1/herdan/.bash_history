clear
cd
ls
clear
ls
cd documents
ls
clear
pip install
sudo apt install pip
sudo pkg install pip
install pip
sudo install jupyter
clear
ls
cat /etc/passwd
cat /etc/passwd | grep "/home"
cat /etc/passwd | grep "/home" | cut -d: -f1
clear
ls
clear
touch user.sh
ls
nano user.sh
chmod +x user.sh
sudo ./user.sh
echo "cek user exist"
sudo ./user.sh
clear
nano analyze_log.sh
chmod +x analyze_log.sh
sudo ./analyze_log.sh
sudo touch /var/log/user_activity.log
sudo nano /var/log/user_activity.log
sudo ./analyze_log.sh
ls
sudo cat /var/log/daily_report.txt
clear
grep " 500 " access.log
clear
nano access.log
grep " 500 " access.log
awk '{print $1}' access.log | sort | uniq
clear
grep "\"GET " access.log | wc -l
awk '{print $1}' access.log | sort | uniq -c | sort -nr | head -n 3
clear
sed 's/ 401 / 403 /g' access.log > access_fixed.log
cat access_fixed.log
clear
grep " 200 " access.log | tail -n 5
clear
awk '$9 == 200 {sum += $10} END {print sum}' access.log
clear
lsbk
clea
clear
lsblk
lspci
lspcl
lsusb
ip addr
lspci
sudo apt install pciutils
lspci
clear
lsusb
sudo apt install usbutils
lsusb
clear
lsblk
lspci
lsusb
ip addr
ping google.com -c 4
traceroute google.com
tempek
echo "tempek"
clear
lsblk
lspci
lsusb
ip addr
ping google.com -c 4
ping google.com 4
traceroute google.com
traceroute
tracerroute
trace
routetrace
tracing
clear
ip addr
clear
ip neigh
ip addr
ls
cap
ping amazon.com
nano users.txt
nano buat_user.sh
chmod +x buat_user.sh
sudo ./buat_user.sh
nano buat_user.sh
chmod +x buat_user.sh
sudo ./buat_user.sh
nano create_user.sh
sudo ./create_user.sh
chmod +x create_user.sh
sudo ./create_user.sh
nano create_user.sh
sudo ./create_user.sh
clear
dd if=/dev/zero of=/tmp/disk_virtual.img bs=1M count=50
mkfs.ext4 /tmp/disk_virtual.img
sudo mkdir -p /mnt/disk_baru
sudo mkdir -p /backup
sudo mount -o loop /tmp/disk_virtual.img /mnt/disk_baru
df -h /mnt/disk_baru
clear
sudo crontab -e
echo "Ini data penting mahasiswa" | sudo tee /mnt/disk_baru/rahasia.txt
sudo tar -czf /backup/backup_test.tar.gz -C /mnt/disk_baru .
mkdir /tmp/hasil_restore
tar -xzf /backup/backup_test.tar.gz -C /tmp/hasil_restore
cat /tmp/hasil_restore/rahasia.txt
nano cek_hdd.sh
chmod +x cek_hdd.sh
sudo ./cek_hdd.sh
nano cek_hdd.sh
chmod +x cek_hdd.sh
sudo ./cek_hdd.sh
sudo tar -czf /backup/backup_test.tar.gz -C /mnt/disk_baru .
mkdir /tmp/hasil_restore
tar -xzf /backup/backup_test.tar.gz -C /tmp/hasil_restore
cat /tmp/hasil_restore/rahasia.txt
ls
clear
sudo mkdir -p /backup
ls
sudo service cron start
ls -lh /backup
mkdir -p ~/hasil_extract
tar -xzvf /backup/backup_kamis.tar.gz -C ~/hasil_extract
ls -lh ~/hasil_extract/mnt/data_baru
ls -lh ~/hasil_extract/mnt/disk_baru
ls
cd hasil_extract
ls -lh ~/hasil_extract/mnt/disk_baru
sudo ls -lh ~/hasil_extract/mnt/disk_baru
mnt/disk_baru
sudo mkdir -p /backup
sudo tar -czf /backup/backup_test.tar.gz -C /mnt/disk_baru .
ls -l /backup
mkdir -p /tmp/hasil_restore
sudo tar -xzf /backup/backup_test.tar.gz -C /tmp/hasil_restore
cat /tmp/hasil_restore/rahasia.txt
cat /tmp/hasil_restore/backup_test.txt
cat /tmp/hasil_restore/backup_test
ls
cd
ls
cd home
ls
clear
ls
ls -lh ~/hasil_extract/mnt/disk_baru
ls -lh ~/hasil_extract/mnt/data_baru
ls -lh ~/hasil_extract
sudo tar -czf /backup/backup_test.tar.gz -C /mnt/disk_baru .
ls -lh ~/hasil_extract
cat ~/hasil_extract/rahasia.txt
tar -tvf /backup/backup_test.tar.gz
ls -lh /mnt/disk_baru
sudo tar -czf /backup/backup_test.tar.gz -C /mnt/disk_baru .
rm -rf ~/hasil_extract && mkdir -p ~/hasil_extract
sudo tar -xzf /backup/backup_test.tar.gz -C ~/hasil_extract
sudo chown -R $USER:$USER ~/hasil_extract
ls -lh ~/hasil_extract
cat ~/hasil_extract/tugas_backup.txt
cat ~/hasil_extract/rahasia.txt
ls
crontab -e
clear
dd if=/dev/zero of=~/disk_baru.img bs=1M count=50
mkfs.ext4 ~/disk_baru.img
sudo mkdir -p /mnt/data_baru
sudo mount -o loop ~/disk_baru.img /mnt/data_baru
sudo mkdir -p /backup
crontab -e
sudo service cron start
ls -lh /backup
mkdir -p ~/hasil_extract
tar -xzvf /backup/backup_kamis.tar.gz -C ~/hasil_extract
ls -lh ~/hasil_extract/mnt/data_baru
ls -lh ~/hasil_extract/mnt/disk_baru
sudo tar -czvf /backup/backup_kamis.tar.gz /mnt/data_baru
ls -lh /backup
tar -xzvf /backup/backup_kamis.tar.gz -C ~/hasil_extract
ls -lh ~/hasil_extract/mnt/data_baru
sudo tar -czvf /backup/backup_test.tar.gz /mnt/data_baru
ls -lh ~/hasil_extract/mnt/disk_baru
sudo tar -czvf /backup/backup_test.tar.gz /mnt/disk_baru
ls -lh ~/hasil_extract/mnt/disk_baru
ls
clear
sudo apt update
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo service docker start
docker --version
sudo snap install docker
ls
docker compose version
