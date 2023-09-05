Unduh skrip zeta.sh dari repositori dengan perintah wget:

bash
Copy code
wget https://github.com/blockReal/Validator-Test/raw/main/Zetachain/zeta.sh
Install dos2unix jika belum ada di sistem Anda (sebagian besar sistem Linux sudah memiliki dos2unix terinstal, jadi ini mungkin hanya diperlukan jika Anda belum menginstalnya sebelumnya):

arduino
Copy code
sudo apt-get install dos2unix
Konversi format skrip menjadi format Unix dengan dos2unix:

Copy code
dos2unix zeta.sh
Berikan izin eksekusi pada skrip:

bash
Copy code
chmod +x zeta.sh
Jalankan skrip zeta.sh:

bash
Copy code
./zeta.sh
