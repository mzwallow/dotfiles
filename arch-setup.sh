#!/bin/bash

sudo pacman -S git go neovim vi vim nano zsh ttf-jetbrains-mono wget \
  noto-fonts noto-fonts-extra noto-fonts-emoji noto-fonts-cjk \
  htop docker docker-compose pipewire pipewire-alsa pipewire-jack \
  pipewire-pulse pavucontrol alsa-firmware sof-firmware alsa-ucm-conf --noconfirm

sudo echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

cd $HOME
mkdir Packages
cd "Packages"
git clone https://aur.archlinux.org/yay.git
cd "yay"
makepkg -sirc

yay -S google-chrome --noconfirm

chsh -s /bin/zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
