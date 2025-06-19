<h1 align="center">
  🖥️ Program Informasi Sistem Berbasis Bash 🖥️
</h1>

<p align="center">
  <img src="https://img.shields.io/badge/language-Bash-blue.svg" alt="Bahasa">
  <img src="https://img.shields.io/badge/platform-Linux-yellow.svg" alt="Platform">
  <img src="https://img.shields.io/badge/status-Selesai-brightgreen" alt="Status">
</p>

<p align="center">
  Sebuah skrip Bash interaktif yang dirancang untuk menampilkan berbagai informasi penting tentang sistem operasi Linux. 
  <br />
  Proyek ini merupakan bagian dari tugas mata kuliah Sistem Operasi.
</p>

---

### **Daftar Isi**

1. [Identitas](#identitas-zap)
2. [Gambaran Singkat Program](#gambaran-singkat-program-mag)
3. [Fitur Program](#fitur-program-rocket)
4. [Catatan Penggunaan](#catatan-penggunaan-warning)
5. [Tools yang Digunakan](#tools-yang-digunakan-hammer_and_wrench)
6. [Kesimpulan](#kesimpulan-memo)

---

### **Identitas** <a name="identitas-zap"></a>

|                 |                                             |
| --------------- | ------------------------------------------- |
| **Nama** | Kadek Gandhi Wahyu Jaya Suastika            |
| **Program Studi** | Teknologi Informasi (06-01)                 |
| **NIM** | 1202230017                                  |

---

### **Gambaran Singkat Program** <a name="gambaran-singkat-program-mag"></a>

> Skrip ini adalah sebuah *dashboard* berbasis terminal yang menyediakan akses cepat ke berbagai metrik dan data sistem. Dengan antarmuka menu yang mudah dinavigasi, pengguna dapat melihat informasi mulai dari sapaan selamat datang, detail jaringan, status sistem operasi, hingga informasi pengguna, semuanya disajikan dalam tabel yang rapi dan berwarna untuk keterbacaan yang lebih baik.

---
![image](https://github.com/user-attachments/assets/ba7e2bf7-3e16-43f0-bd7c-da628f5f9c95)


### **Fitur Program** <a name="fitur-program-rocket"></a>

Berikut adalah penjelasan untuk setiap menu yang tersedia dalam program ini:

#### **1. 👋 Greeting User**
Menu ini memberikan sapaan hangat kepada pengguna yang disesuaikan dengan waktu (Pagi, Siang, Sore, Malam). Selain itu, menu ini juga menampilkan rangkuman informasi dasar seperti tanggal, waktu, dan info kalender dalam format tabel yang jelas.

![image](https://github.com/user-attachments/assets/98e91cd7-9113-4738-a7f3-3695245b8114)



#### **2. 📁 Info Daftar Direktori**
Fitur ini berfungsi seperti perintah `ls -l` yang ditingkatkan. Ia menampilkan seluruh isi dari direktori tempat skrip dijalankan dalam sebuah tabel detail, lengkap dengan hak akses, pemilik, ukuran, tanggal modifikasi, dan nama file/direktori. Direktori dan file yang bisa dieksekusi diberi warna berbeda untuk identifikasi yang lebih mudah.

![image](https://github.com/user-attachments/assets/ae7d9e0d-53ea-4258-9688-c707522288f5)


#### **3. 🌐 Info Jaringan**
Ini adalah menu paling komprehensif untuk analisis jaringan. Fitur ini menampilkan:
* Status koneksi internet (terhubung atau tidak).
* Detail IP Publik, lengkap dengan perkiraan lokasi geografis (Kota, Wilayah, Negara), kode pos, zona waktu, dan nama ISP.
* Daftar semua alamat IP lokal beserta Netmask/CIDR-nya.
* Status detail setiap *interface* jaringan (UP/DOWN), kecepatan link, dan alamat MAC.

![image](https://github.com/user-attachments/assets/e9557d8f-d6b5-400d-938e-9805b35c3179)


#### **4. 💻 Info OS**
Menampilkan rangkuman teknis dari sistem operasi yang sedang berjalan. Informasi yang disajikan meliputi nama distro, versi kernel, arsitektur, penggunaan CPU *real-time* (user, system, idle), serta tabel penggunaan Memori (RAM) dan Swap.

![image](https://github.com/user-attachments/assets/60d52ffd-416b-4cfd-ba21-b883612f6e13)

#### **5. ⏳ Waktu Install OS**
Fitur unik yang mencoba mendeteksi kapan sistem operasi ini pertama kali diinstal. Skrip akan mencoba beberapa metode, seperti memeriksa log installer atau waktu pembuatan partisi, untuk memberikan perkiraan tanggal instalasi yang akurat. Selain itu, menu ini juga menampilkan waktu boot terakhir dan durasi sistem telah berjalan (*uptime*).

![image](https://github.com/user-attachments/assets/8b90ffaf-dc6d-4102-8841-217773005e65)

#### **6. 👤 Info User**
Menyediakan semua detail terkait pengguna yang sedang login, termasuk nama pengguna, UID, GID, daftar grup, direktori home, shell yang digunakan, dan total penggunaan disk pada direktori `/home`. Menu ini juga menampilkan sesi login yang sedang aktif dan 5 riwayat login terakhir.

![image](https://github.com/user-attachments/assets/3739c4a3-5c8b-49b5-ba0e-142a2e8f3166)

---

### **Catatan Penggunaan** <a name="catatan-penggunaan-warning"></a>

Untuk menjalankan skrip ini dengan benar, ikuti langkah-langkah berikut:

1.  **Pastikan berada di lingkungan terminal Linux.**
2.  **Berikan izin eksekusi** pada file skrip dengan perintah berikut:
    ```bash
    chmod +x nama_file_skrip_anda.sh
    ```
3.  **Pastikan `curl` dan `figlet` sudah terinstal** agar semua fitur dapat berjalan optimal.
    <details>
    <summary>Klik untuk melihat perintah instalasi</summary>
    
    ```bash
    # Untuk sistem berbasis Debian/Ubuntu
    sudo apt update && sudo apt install curl figlet

    # Untuk sistem berbasis Fedora/CentOS
    sudo dnf install curl figlet
    ```
    </details>

4.  **Jalankan skrip:**
    ```bash
    ./nama_file_skrip_.sh
    ```
    #atau bisa juga
    bash + nama_file_skrip_.sh
---

### **Tools yang Digunakan** <a name="tools-yang-digunakan-hammer_and_wrench"></a>

Skrip ini memanfaatkan beberapa *command-line tools* bawaan Linux untuk mengumpulkan data:

* `figlet`: Untuk membuat variasi teks ASCII pada judul.
* `curl`: Untuk mengambil data IP publik dan informasi lokasi dari API eksternal.
* `nmcli`: Untuk mendapatkan status koneksi yang dikelola oleh NetworkManager.
* `ip`: Utilitas modern untuk menampilkan dan memanipulasi informasi jaringan.
* `stat`, `df`, `free`: Perintah standar untuk mendapatkan metadata file, status disk, dan penggunaan memori.
* `uptime`, `last`, `w`: Untuk mendapatkan informasi waktu aktif, riwayat, dan sesi login pengguna.

---

### **Kesimpulan** <a name="kesimpulan-memo"></a>

Program ini menunjukkan bagaimana *shell scripting* Bash dapat digunakan untuk membuat alat bantu sistem yang fungsional, informatif, dan menarik secara visual. Dengan menggabungkan berbagai perintah Linux dan memformat outputnya, skrip ini menjadi sebuah *dashboard* mini yang sangat berguna untuk memantau kondisi sistem secara cepat dan efisien.
![image](https://github.com/user-attachments/assets/cd54b3c8-317c-4d49-bae7-859ad9f7aeaa)


IT SOLID!

<p align="right"><a href="#top">Kembali ke atas ↑</a></p>
