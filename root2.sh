#!/bin/bash

RED='\033[0;31m'
BLUE="\033[0;34m"
GREEN="\033[0;32m"
NC='\033[0m' # No Color

keys=es
chr=chroot.sh
pckgs=pckgs
boot=/dev/nvme0n1p1
root=/dev/nvme0n1p2
home=/dev/nvme0n1p3
swap=/dev/nvme0n1p4
uefi=true

log() {
    respuesta=$1
    msg=$2
    time=$(date '+%d/%m/%Y %H:%M:%S')
    color=$BLUE

    if [  $respuesta == 1  ]; then
        color=$GREEN
        respuesta=ok
    else 
        if [  $respuesta == 0  ]; then
            color=$RED
            respuesta=error
        fi
    fi

    echo -e "$time $msg... ${color}[$respuesta]${NC}"
    # if [  $respuesta = "error"  ]; then
    #     exit 1
    # fi
}

checkInternet() {
    if ping -c1 google.com &> /dev/null; then
        echo 1;
    fi

    echo 0
}

checkDir() {
    local dir=${1:?Debe proveer un argumento.}
    
    if [[ -d "$dir" ]]; then
        echo 1;
    else
        echo 0;
    fi
}

checkDirInv() {
    local dir=${1:?Debe proveer un argumento.}
    
    if [[ -d "$dir" ]]; then
        echo 0;
    else
        echo 1;
    fi
}

checkFile() {
    local dir=${1:?Debe proveer un argumento.}
    
    if [[ -f "$dir" ]]; then
        echo 1;
    else
        echo 0;
    fi
}

checkFileInv() {
    local dir=${1:?Debe proveer un argumento.}
    
    if [[ -f "$dir" ]]; then
        echo 0;
    else
        echo 1;
    fi
}

# Formato y administración de discos.
# Esta función presupone el siguiente particionado de disco:

#     boot /dev/sda1	  /boot	  150MB	*Bootable
#     root /dev/sda2	  /	  –
#     home /dev/sda3	  /home	  - 
#     swap /dev/sda4	  /swap	  2GB	* Type: Linux Swap / Solaris

# Se puede obtener con el comando cfdisk antes de ejecutar el script.
# !Función pendiente de automatizar.
adminDiscos() {
    if [  $uefi = true ]; then
        mkfs.vfat -F32 $boot &> /dev/null
        log 1 "$boot BOOT formateado en modo UEFI "
    else
        mkfs.ext2 $boot &> /dev/null
        log 1 "$boot BOOT formateado en modo BIOS "
    fi
    mkfs.ext4 $root &> /dev/null
    log 1 "$root ROOT formateado"
    mkfs.ext4 $home &> /dev/null
    log 1 "$home HOME formateado"
    mkswap $swap &> /dev/null
    swapon $swap &> /dev/null
    log 1 "$swap SWAP configurado"
    mount $root /mnt &> /dev/null
    log 1 "$root ROOT montado en /mnt"
    if [  $uefi = true ]; then
        mkdir -p /mnt/boot/efi &> /dev/null
        mount $boot /mnt/boot/efi &> /dev/null
        log 1 "$boot BOOT montado en /mnt/boot/efi (UEFI)"
    else
        mkdir /mnt/boot &> /dev/null
        mount $boot /mnt/boot &> /dev/null
        log 1 "$boot BOOT montado en /mnt/boot (BIOS)"
    fi
    mkdir /mnt/home &> /dev/null
    mount $home /mnt/home &> /dev/null
    log 1 "$home HOME montado en /mnt/home"
}

instalacionBase() {
    log 1 "Inicialización e instalación de sistema base"
    pacstrap /mnt base base-devel grub ntfs-3g networkmanager efibootmgr gvfs gvfs-mtp xdg-user-dirs nano wpa_supplicant dialog xf86-input-synaptics linux linux-firmware dhcpcd
    if [  $uefi = true ]; then
        pacstrap /mnt efibootmgr 
    fi
    genfstab -U -p /mnt >> /mnt/etc/fstab
}

jaulaChroot() {
    cp $chr /mnt
    cp $pckgs /mnt
    chmod +x /mnt/$chr
    arch-chroot /mnt ./$chr
    umount /mnt/boot &> /dev/null
    umount /mnt/home &> /dev/null
    umount /mnt &> /dev/null
}

adminDiscos
log $(checkInternet) Checkeando internet
instalacionBase
jaulaChroot