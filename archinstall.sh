#!/bin/env bash
set -euo pipefail

BLACK="\e[30m"
RED="\e[31m"
YELLOW="\e[33m"
YELLOW_BG="\e[30;43m"
ENDCOLOR="\e[0m"

# ====
echo "Updating the system clock"
timedatectl set-timezone "Asia/Bangkok"
timedatectl set-ntp true

# TODO: Dynamically partition the disks
# ====
# List all available devices
DISKS=()
while IFS='' read -r value; do
    DISKS+=("$value")
done <<<"$(fdisk -l | grep "Disk /dev/*")"

for i in "${DISKS[@]}"; do
    fdisk -l "$(echo "$i" | sed -E "s/.*(\/dev\/\S+):.*/\1/")"
done

# ====
echo "Formatting the partitions"
for (( ; ; ))
do
    read -rp "EFI system partition (e.g. /dev/sda1): " efipart
    if [[ -z "$efipart" ]]; then
	echo -e "${YELLOW_BG}WARNING: EFI system partition must be specified${ENDCOLOR}\n"
    else
	break
    fi
done

read -rp "Swap partition (e.g. /dev/sda2) (optional): " swappart

for (( ; ; ))
do
    read -rp "Root partition (e.g. /dev/sda3): " rootpart
    if [[ -z "$rootpart" ]]; then
	echo -e "${YELLOW_BG}WARNING: Root partition must be specified${ENDCOLOR}\n"
    else
	break
    fi
done

mkfs.fat -F 32 "$efipart"
mkswap "$swappart"
mkfs.ext4 "$rootpart"

# ====
echo "Moutning the file systems"
mount "$rootpart" /mnt
mount --mkdir "$efipart" /mnt/boot
swapon "$swappart"

# ====
echo "Updating pacman mirrorlist"
reflector --save /etc/pacman.d/mirrorlist \
    --ipv4 --ipv6 --protocol https --latest 20 --sort rate

# ===
echo "Installing essential packages"
ESSENTIAL_PACKAGES=(
    base linux linux-firmware base-devel linux-headers
    # Development
    git
    # Network
    networkmanager nm-connection-editor network-manager-applet
    # Text editor
    vim nano nvim
    # Documentation
    man-db man-pages texinfo
)
for pkg in "${ESSENTIAL_PACKAGES[@]}"; do
    pacstrap -K /mnt "$pkg"
done

# TODO: Configure the system
