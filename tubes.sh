#!/bin/bash

# ==============================================================================
# FUNGSI-FUNGSI PEMBANTU
# ==============================================================================

# Fungsi untuk menampilkan judul.
# Menggunakan figlet jika terinstal, jika tidak, menggunakan teks biasa.
# Argumen: $1 - Teks judul yang akan ditampilkan.
tampilkan_judul() {
    # Ini untuk memeriksa apakah perintah figlet tersedia di sistem.
    if command -v figlet &> /dev/null; then
        # Ini untuk menampilkan judul menggunakan figlet dengan font slant dan rata tengah.
        figlet -c -f slant "$1"
    else
        # Ini adalah alternatif jika figlet tidak terinstal.
        local judul_teks="$1"
        local panjang_judul=${#judul_teks}
        local lebar_terminal=$(tput cols 2>/dev/null || echo 80) # Ini untuk mendapatkan lebar terminal.
        local padding_total=$((lebar_terminal - panjang_judul - 4))
        local padding_kiri=$((padding_total / 2))
        local padding_kanan=$((padding_total - padding_kiri))

        # Ini untuk mencetak judul dengan format manual agar rata tengah.
        printf "\n"
        printf "#%.0s" $(seq 1 $lebar_terminal) | tr '0' '#'
        printf "\n"
        printf "# %*s%s%*s #\n" $padding_kiri "" "$judul_teks" $padding_kanan ""
        printf "#%.0s" $(seq 1 $lebar_terminal) | tr '0' '#'
        printf "\n"
    fi
}

# ==============================================================================
# FUNGSI-FUNGSI MENU UTAMA
# ==============================================================================

# Fungsi untuk menampilkan informasi jaringan.
informasi_jaringan() {
    clear # Ini untuk membersihkan layar terminal.
    tampilkan_judul "Info Jaringan" # Ini untuk menampilkan judul halaman "Info Jaringan".
    echo ""
    echo "============================================================"
    
    # 1. Cek Koneksi Internet
    # Ini untuk memeriksa koneksi ke internet dengan melakukan ping ke server DNS Google.
    echo -n "   Status Koneksi Internet   : "
    if ping -c 1 -W 1 8.8.8.8 &> /dev/null || ping -c 1 -W 1 1.1.1.1 &> /dev/null; then
        echo "Terhubung"
    else
        echo "Putus / Tidak Terhubung"
    fi
    echo ""

    # 2. Tampilkan Konfigurasi Jaringan Lokal
    echo "   --- Konfigurasi Jaringan Lokal ---"
    echo "   Alamat IP Lokal (IPv4)    :"
    # Ini untuk menampilkan semua alamat IP versi 4 yang aktif.
    ip -4 addr show scope global | awk '/inet / {printf "     Interface %-10s : %s\n", $NF, $2}' | sed 's|/.*||'
    
    # Ini untuk menampilkan IP utama melalui perintah hostname.
    LOCAL_IPS_HOSTNAME=$(hostname -I 2>/dev/null | awk '{print $1}') 
    if [ -n "$LOCAL_IPS_HOSTNAME" ]; then
        echo "     (IP Utama via hostname -I : $LOCAL_IPS_HOSTNAME)"
    fi
    echo ""

    # Ini untuk menampilkan alamat gateway default.
    echo -n "   Gateway Utama             : "
    GATEWAY=$(ip route | grep '^default' | awk '{print $3}')
    if [ -n "$GATEWAY" ]; then
        echo "$GATEWAY"
    else
        echo "Tidak ditemukan"
    fi
    echo ""

    # Ini untuk menampilkan alamat server DNS dari file konfigurasi.
    echo "   DNS Server (dari /etc/resolv.conf):"
    if [ -f /etc/resolv.conf ] && grep -q "^nameserver" /etc/resolv.conf; then
        grep "^nameserver" /etc/resolv.conf | awk '{print "     " $2}'
    else
        echo "     Tidak ada nameserver dikonfigurasi atau file tidak ditemukan."
    fi
    echo ""

    # 3. Tampilkan IP Publik dan Lokasi
    echo "   --- IP Publik & Lokasi ---"
    PUBLIC_IP=""
    echo "   Mencoba mengambil IP Publik..."
    # Ini untuk mencoba mengambil alamat IP publik dari layanan online.
    if command -v curl &> /dev/null; then
        PUBLIC_IP=$(curl -s --max-time 5 api.ipify.org || curl -s --max-time 5 icanhazip.com || curl -s --max-time 5 ifconfig.me/ip)
    elif command -v wget &> /dev/null; then
        PUBLIC_IP=$(wget -qO- --timeout=5 api.ipify.org || wget -qO- --timeout=5 icanhazip.com || wget -qO- --timeout=5 ifconfig.me/ip)
    fi

    # Ini untuk memvalidasi IP publik dan mengambil data lokasi jika IP valid.
    if [[ -n "$PUBLIC_IP" && "$PUBLIC_IP" == *.* && "$PUBLIC_IP" != *"<html>"* && "$PUBLIC_IP" != *"<HTML>"* ]]; then
        echo "   IP Publik Anda adalah       : $PUBLIC_IP"
        echo "   Mencoba mengambil info lokasi (via ipinfo.io & ip-api.com)..."

        LOCATION_INFO_JSON="" # Ini untuk menyimpan data JSON dari ipinfo.io
        TOKEN_IPINFO=""
        URL_IPINFO="ipinfo.io/$PUBLIC_IP"
        [ -n "$TOKEN_IPINFO" ] && URL_IPINFO="$URL_IPINFO?token=$TOKEN_IPINFO"

        # Ini untuk mengambil data lokasi dari ipinfo.io.
        if command -v wget &> /dev/null; then
            LOCATION_INFO_JSON=$(wget -qO- --timeout=7 "$URL_IPINFO")
        elif command -v curl &> /dev/null; then
            LOCATION_INFO_JSON=$(curl -s --max-time 7 "$URL_IPINFO")
        fi
        
        # Ini untuk mem-parsing (mengurai) data JSON dari ipinfo.io untuk mendapatkan detail lokasi.
        CITY_IO=$(echo "$LOCATION_INFO_JSON" | grep -oP '"city":\s*"\K[^"]*')
        REGION_IO=$(echo "$LOCATION_INFO_JSON" | grep -oP '"region":\s*"\K[^"]*')
        COUNTRY_IO=$(echo "$LOCATION_INFO_JSON" | grep -oP '"country":\s*"\K[^"]*')
        ORG_IO=$(echo "$LOCATION_INFO_JSON" | grep -oP '"org":\s*"\K[^"]*')
        POSTAL_IO=$(echo "$LOCATION_INFO_JSON" | grep -oP '"postal":\s*"\K[^"]*')
        TIMEZONE_IO=$(echo "$LOCATION_INFO_JSON" | grep -oP '"timezone":\s*"\K[^"]*')

        # Ini untuk menampilkan detail lokasi jika berhasil didapatkan dari ipinfo.io.
        if [ -n "$CITY_IO" ] || [ -n "$REGION_IO" ] || [ -n "$COUNTRY_IO" ]; then
            echo "     Detail Lokasi (dari ipinfo.io):"
            printf "       %-28s : %s\n" "Kota" "${CITY_IO:-Tidak dapat ditentukan}"
            printf "       %-28s : %s\n" "Wilayah (Region)" "${REGION_IO:-Tidak dapat ditentukan}"
            printf "       %-28s : %s\n" "Negara" "${COUNTRY_IO:-Tidak dapat ditentukan}"
            printf "       %-28s : %s\n" "Kode Pos" "${POSTAL_IO:-Tidak dapat ditentukan}"
            printf "       %-28s : %s\n" "Zona Waktu" "${TIMEZONE_IO:-Tidak dapat ditentukan}"
            printf "       %-28s : %s\n" "Organisasi/ISP" "${ORG_IO:-Tidak dapat ditentukan}"
        else
            # Ini adalah alternatif jika ipinfo.io gagal, mencoba ke ip-api.com.
            echo "     Gagal parse dari ipinfo.io atau data tidak lengkap. Mencoba ip-api.com..."
            LOCATION_ALT_LINE=""
            URL_IPAPI="http://ip-api.com/line/${PUBLIC_IP}?fields=status,message,country,regionName,city,zip,timezone,isp,org"
            
            if command -v wget &> /dev/null; then
                LOCATION_ALT_LINE=$(wget -qO- --timeout=7 "$URL_IPAPI")
            elif command -v curl &> /dev/null; then
                 LOCATION_ALT_LINE=$(curl -s --max-time 7 "$URL_IPAPI")
            fi

            # Ini untuk mem-parsing dan menampilkan data dari ip-api.com jika berhasil.
            if echo "$LOCATION_ALT_LINE" | grep -q -E "^success"; then
                echo "     Detail Lokasi (dari ip-api.com):"
                COUNTRY_ALT=$(echo "$LOCATION_ALT_LINE" | awk 'NR==2 {print}')
                REGION_ALT=$(echo "$LOCATION_ALT_LINE" | awk 'NR==3 {print}')
                CITY_ALT=$(echo "$LOCATION_ALT_LINE" | awk 'NR==4 {print}')
                ZIP_ALT=$(echo "$LOCATION_ALT_LINE" | awk 'NR==5 {print}')
                TIMEZONE_ALT=$(echo "$LOCATION_ALT_LINE" | awk 'NR==6 {print}')
                ISP_ALT=$(echo "$LOCATION_ALT_LINE" | awk 'NR==7 {print}')
                ORG_ALT=$(echo "$LOCATION_ALT_LINE" | awk 'NR==8 {print}')
                
                printf "       %-28s : %s\n" "Kota" "${CITY_ALT:-Tidak dapat ditentukan}"
                printf "       %-28s : %s\n" "Wilayah (Region)" "${REGION_ALT:-Tidak dapat ditentukan}"
                printf "       %-28s : %s\n" "Negara" "${COUNTRY_ALT:-Tidak dapat ditentukan}"
                printf "       %-28s : %s\n" "Kode Pos" "${ZIP_ALT:-Tidak dapat ditentukan}"
                printf "       %-28s : %s\n" "Zona Waktu" "${TIMEZONE_ALT:-Tidak dapat ditentukan}"
                printf "       %-28s : %s\n" "ISP" "${ISP_ALT:-Tidak dapat ditentukan}"
                printf "       %-28s : %s\n" "Organisasi" "${ORG_ALT:-Tidak dapat ditentukan}"
            else
                echo "     Gagal mengambil detail lokasi dari ipinfo.io maupun ip-api.com."
            fi
        fi
    else
        # Ini untuk menampilkan pesan jika IP publik tidak bisa didapatkan.
        echo "   Tidak dapat mengambil IP Publik atau format IP tidak valid."
        echo "   Pastikan wget/curl terinstall dan Anda terhubung ke internet."
    fi
    echo "============================================================"
    echo ""
}

# Fungsi untuk menampilkan informasi pengguna.
informasi_user() {
    clear # Ini untuk membersihkan layar.
    tampilkan_judul "Info User" # Ini untuk menampilkan judul halaman "Info User".
    echo ""
    echo "============================================================"
    CURRENT_USER=$(id -un) # Ini untuk mendapatkan nama user yang sedang login.
    
    # Ini untuk menampilkan informasi dasar terkait user.
    printf "   %-32s : %s\n" "Nama User Saat Ini" "$CURRENT_USER"
    printf "   %-32s : %s\n" "User ID (UID)" "$(id -u $CURRENT_USER)"
    printf "   %-32s : %s\n" "Group ID (GID Utama)" "$(id -g $CURRENT_USER)"
    printf "   %-32s : %s\n" "Nama Grup Utama" "$(id -gn $CURRENT_USER)"
    printf "   %-32s : %s\n" "Anggota Grup Lain" "$(groups $CURRENT_USER)"
    printf "   %-32s : %s\n" "Direktori Home" "$HOME"
    printf "   %-32s : %s\n" "Shell Login" "$SHELL"
    printf "   %-32s : %s\n" "Terminal Saat Ini" "$(tty)"
    echo ""
    
    # Ini untuk menampilkan informasi sesi login aktif dari user.
    echo "   --- Informasi Sesi Login Saat Ini (perintah 'w') ---"
    if command -v w &> /dev/null; then
        w $CURRENT_USER | sed 's/^/     /'
    else
        echo "     Perintah 'w' tidak ditemukan."
    fi
    echo ""
    
    # Ini untuk menampilkan 5 riwayat login terakhir dari user.
    echo "   --- Riwayat Login Terakhir (5 entri untuk user $CURRENT_USER) ---"
    if command -v last &> /dev/null; then
        last -n 5 $CURRENT_USER | sed 's/^/     /'
    else
        echo "     Perintah 'last' tidak ditemukan."
    fi
    echo ""
    
    # Ini untuk menampilkan total penggunaan disk pada direktori home user.
    echo "   --- Penggunaan Disk oleh User di Direktori Home ---"
    if [ -d "$HOME" ]; then
        du -sh "$HOME" | awk '{printf "     Total Penggunaan: %s\tDirektori: %s\n", $1, $2}'
    else
        echo "     Direktori home ($HOME) tidak ditemukan."
    fi
    echo "============================================================"
    echo ""
}

# ==============================================================================
# PROGRAM UTAMA (MENU)
# ==============================================================================

clear # Ini untuk membersihkan layar saat program pertama kali dijalankan.
# Ini adalah loop utama program agar menu terus ditampilkan.
while true; do
    clear # Ini untuk membersihkan layar di setiap awal perulangan menu.
    tampilkan_judul "Menu Biasa Aja" # Ini untuk menampilkan judul utama aplikasi.
    echo ""

    # Ini adalah variabel untuk mengatur lebar konten menu.
    menu_content_width=35
    # Ini untuk menghitung total lebar tabel menu.
    total_line_width=$((menu_content_width + 4))

    # Ini adalah fungsi lokal untuk mencetak garis horizontal pada tabel menu.
    print_horizontal_line() {
        printf "+%.0s" $(seq 1 $total_line_width) | tr '0' '-'
        printf "\n"
    }

    # Ini adalah fungsi lokal untuk mencetak setiap baris pilihan pada tabel menu.
    print_menu_option() {
        local option_text="$1"
        printf "| %-*.*s |\n" $menu_content_width $menu_content_width "$option_text"
    }
    
    # Ini untuk menampilkan kotak menu beserta opsinya.
    print_horizontal_line
    print_menu_option " 1. Inpo Jaringan"
    print_menu_option " 2. Inpo User"
    print_menu_option " 3. Exit Program"
    print_horizontal_line
    echo ""

    # Ini untuk meminta input dari pengguna.
    printf "%*s" $(( (total_line_width - 20) / 2 )) ""
    read -p "Pilih opsi [1-3]: " pilihan

    # Ini untuk memproses pilihan yang diinput oleh pengguna.
    case $pilihan in
        1) 
            informasi_jaringan
            # PERBAIKAN: Dapatkan lebar terminal ke variabel dulu
            lebar_prompt=$(tput cols 2>/dev/null || echo 80)
            # Ini untuk menjeda layar hingga pengguna menekan sebuah tombol.
            printf "\n%*s" $(( (lebar_prompt - 38) / 2 )) ""
            read -n 1 -s -r -p "Tekan tombol apa saja untuk kembali..."
            ;;
        2) 
            informasi_user
            # PERBAIKAN: Dapatkan lebar terminal ke variabel dulu
            lebar_prompt=$(tput cols 2>/dev/null || echo 80)
            printf "\n%*s" $(( (lebar_prompt - 38) / 2 )) ""
            read -n 1 -s -r -p "Tekan tombol apa saja untuk kembali..."
            ;;
        3) 
            # Ini untuk keluar dari program.
            clear
            tampilkan_judul "XIE XIE YA!"
            sleep 2
            clear
            exit 0
            ;;
        *) 
            # Ini untuk menangani jika pengguna menginput pilihan yang salah.
            clear
            tampilkan_judul "Input Salah!"
            if command -v figlet &> /dev/null; then
                figlet -c -w 60 "Pilihan '$pilihan' Gak Ada Bang!"
            else
                echo ""
                echo "   Pilihan '$pilihan' tidak valid! Silakan coba lagi."
            fi
            echo ""
            # PERBAIKAN: Dapatkan lebar terminal ke variabel dulu
            lebar_prompt=$(tput cols 2>/dev/null || echo 80)
            printf "%*s" $(( (lebar_prompt - 38) / 2 )) ""
            read -n 1 -s -r -p "Tekan tombol apa saja untuk lanjut..."
            ;;
    esac
done
