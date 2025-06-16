# 📝 Tugas Besar Sistem Operasi
### 1202230017 - Kadek Gandhi Wahyu Jaya Suastika

![Tugas: Sistem Operasi](https://img.shields.io/badge/Tugas-Sistem%20Operasi-blue?style=for-the-badge&logo=linux-terminal)
![Universitas: Telkom Surabaya](https://img.shields.io/badge/Universitas-Telkom%20Surabaya-red?style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB2ZXJzaW9uPSIxLjEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHZpZXdCb3g9IjAgMCAxNzIgMTcyIj48ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9Im5vbnplcm8iIHN0cm9rZT0ibm9uZSIgc3Ryb2tlLXdpZHRoPSIxIiBzdHJva2UtbGluZWNhcD0iYnV0dCIgc3Ryb2tlLWxpbmVqb2luPSJtaXRlciIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBzdHJva2UtZGFzaGFycmF5PSIiIHN0cm9rZS1kYXNob2Zmc2V0PSIwIiBmb250LWZhbWlseT0ibm9uZSIgZm9udC13ZWlnaHQ9Im5vbmUiIGZvbnQtc2l6ZT0ibm9uZSIgdGV4dC1hbmNob3I9Im5vbmUiIHN0eWxlPSJtaXhlLWJsZW5kLW1vZGU6IG5vcm1hbCI+PHBhdGggZD0iTTAsMTcydi0xNzJoMTcydjE3MnoiIGZpbGw9Im5vbmUiPjwvcGF0aD48ZyBmaWxsPSIjZmZmZmZmIj48cGF0aCBkPSJNNzEuNjgsMjEuNWMtMy4xNTQyNSwwIC01LjcxNjY3LDIuNTYyNDIgLTUuNzE2NjcsNS43MTY2N3YxMTAuOTgzMzNjMCwzLjE1NDI1IDIuNTYyNDIsNS43MTY2NyA1LjcxNjY3LDUuNzE2NjdjMy4xNTQyNSwwIDUuNzE2NjcsLTIuNTYyNDIgNS43MTY2NywtNS43MTY2N3YtMTEwLjk4MzMzYzAsLTMuMTU0MjUgLTIuNTYyNDIsLTUuNzE2NjcgLTUuNzE2NjcsLTUuNzE2Njd6TTM1Ljg0LDUwLjE2NjY3Yy0yLjA5NjI1LDAgLTMuOTQ3NzUsMS4yMjMyNSAtNC44MzMyNSwzLjExMTQybC0xMS40MTY2NywyMy45NzVjLTEuNTM3NSwzLjIzMTc1IC0wLjQ4NTI1LDcuMjAzNSA1LjcxNjY3LDcuMjAzNWgxNS4yNDMzM2M1LjYyNDUsMCA4LjU1ODUsLTQuNjMyNSA1LjcxNjY3LC03LjIwMzVsLTExLjQxNjY3LC0yMy45NzVjLTAuODg1NSwtMS44ODgxNyAtMi43Mzc1LC0zLjExMTQyIC00LjgzMzI1LC0zLjExMTQyeiBNMTA3LjUsNTEuNWMtMjMuODUxMjUsMCAtNDMuLDExLjgyMzUgLTQzLDM0LjVjMCwyMi42NzY1IDIxLjE2NjUsMzQuNSA0MywzNC41YzIxLjgzMzUsMCA0MywtMTEuODIzNSA0MywtMzQuNWMwLC0yMC42MjUgLTE3LjM3NSwtMzQuNSAtNDMsLTM0LjV6TTEwNy41LDYyLjgzMzMzYzE0LjI1ODUsMCAyMS41LDcuOTUzNzUgMjEuNSwyMy42NjY2N2MwLDE1LjcxMjkxIC03LjIyMTUsMjMuNjY2NjcgLTIxLjUsMjMuNjY2NjdzLTIxLjUsLTcuOTUzNzUgLTIxLjUsLTIzLjY2NjY3YzAsLTE1LjcxMjkxIDcuMjU5MTcsLTIzLjY2NjY3IDIxLjUsLTIzLjY2NjY3eiI+PC9wYXRoPjwvZz48L2c+PC9zdmc+)

Skrip ini dibuat untuk memenuhi asesmen mata kuliah **SISTEM OPERASI IT 06-01** di Telkom University Surabaya. Saya memilih 2 dari 6 menu opsional yang tersedia, yaitu informasi jaringan dan informasi pengguna. Secara keseluruhan, skrip ini berfungsi sebagai alat interaktif untuk menampilkan data sistem secara ringkas dan jelas.

---

## 🚀 Cara Penggunaan

1.  **Berikan izin eksekusi**: `chmod +x tubes.sh`
2.  **Jalankan**: `./tubes.sh`
3.  Pilih menu yang tersedia pada antarmuka.

---

### 🎨 Fungsi: `tampilkan_judul()`
Fungsi ini bertanggung jawab untuk mencetak judul yang menarik di setiap halaman menu.

-   **Output Informasi:**
    -   Judul halaman artistik menggunakan `figlet` (jika terinstal).
    -   Judul teks biasa yang rapi dan berada di tengah layar (jika `figlet` tidak ada).

<details>
<summary><strong>Lihat Penjelasan Kode</strong></summary>

-   **Penjelasan Singkat Kode:**
    -   `command -v figlet` digunakan untuk memeriksa ketersediaan `figlet`.
    -   Jika tidak ada, `tput cols` akan mengambil lebar terminal, lalu `printf` menghitung *padding* agar teks judul menjadi rata tengah secara manual.
</details>

### 🌐 Fungsi: `informasi_jaringan()`
Menampilkan semua informasi yang relevan terkait konfigurasi dan status jaringan.

-   **Output Informasi:**
    -   **Status Koneksi Internet**: Menampilkan "Terhubung" atau "Putus / Tidak Terhubung".
    -   **Alamat IP Lokal**: Daftar semua alamat IPv4 yang aktif (`wlan0`, `eth0`, dll).
    -   **Gateway Utama**: Alamat IP dari *gateway default*.
    -   **Server DNS**: Daftar alamat IP server DNS yang digunakan.
    -   **IP Publik**: Alamat IP publik Anda yang terlihat di internet.
    -   **Info Lokasi**: Detail geolokasi (Kota, Wilayah, Negara, ISP, Zona Waktu) berdasarkan IP publik.

<details>
<summary><strong>Lihat Penjelasan Kode</strong></summary>

-   **Penjelasan Singkat Kode:**
    -   **Koneksi**: Mengirim `ping -c 1` ke `8.8.8.8` dan `1.1.1.1` sebagai cadangan.
    -   **IP Lokal**: Mengurai output `ip -4 addr show scope global` menggunakan `awk` dan `sed`.
    -   **Gateway**: Menyaring `ip route | grep '^default'` untuk menemukan *gateway*.
    -   **DNS**: Membaca file `/etc/resolv.conf` dengan `grep`.
    -   **IP Publik**: Menggunakan `curl` atau `wget` ke layanan online seperti `api.ipify.org`.
    -   **Lokasi**: Melakukan kueri ke API `ipinfo.io`, dengan *fallback* ke `ip-api.com` jika gagal. Hasilnya diurai dengan `grep` atau `awk`.
</details>

### 👤 Fungsi: `informasi_user()`
Menampilkan data detail mengenai pengguna yang sedang menjalankan skrip.

-   **Output Informasi:**
    -   **Info Dasar**: Nama pengguna, UID, GID utama, dan daftar grup.
    -   **Direktori & Shell**: Path ke direktori `home` dan *shell login* default.
    -   **Sesi Aktif**: Informasi sesi terminal yang sedang berjalan dari perintah `w`.
    -   **Riwayat Login**: 5 entri riwayat login terakhir dari perintah `last`.
    -   **Penggunaan Disk**: Total ukuran penyimpanan direktori `home` pengguna.

<details>
<summary><strong>Lihat Penjelasan Kode</strong></summary>

-   **Penjelasan Singkat Kode:**
    -   **Info Dasar**: Menggunakan perintah `id`, `groups`, dan variabel lingkungan seperti `$HOME` dan `$SHELL`.
    -   **Sesi Aktif**: Menjalankan `w $CURRENT_USER` untuk melihat sesi aktif.
    -   **Riwayat Login**: Menjalankan `last -n 5 $CURRENT_USER` untuk menyaring log sistem.
    -   **Penggunaan Disk**: Menjalankan `du -sh "$HOME"` untuk kalkulasi ringkas.
</details>

### 🔄 Program Utama (Loop Menu)
Bagian ini mengontrol alur program dan interaksi pengguna.

-   **Output Informasi:**
    -   Menu utama dengan pilihan yang jelas (Info Jaringan, Info User, Exit).
    -   Prompt untuk input pengguna.
    -   Pesan kesalahan jika input tidak valid.

<details>
<summary><strong>Lihat Penjelasan Kode</strong></summary>

-   **Penjelasan Singkat Kode:**
    -   `while true` menciptakan sebuah *loop* tak terbatas agar program terus berjalan.
    -   `case $pilihan in ... esac` mengevaluasi input pengguna untuk memanggil fungsi yang sesuai atau keluar dari program.
    -   `read -n 1 -s -r -p "..."` digunakan untuk menjeda skrip, menunggu pengguna menekan tombol sebelum kembali ke menu utama.
</details>
