#!/bin/bash

sudo pacman -S zsh ttf-jetbrains-mono wget \
  noto-fonts noto-fonts-extra noto-fonts-emoji noto-fonts-cjk \
  htop docker docker-compose pipewire pipewire-alsa pipewire-jack \
  pipewire-pulse pavucontrol alsa-firmware sof-firmware alsa-ucm-conf \
  tree kitty picom pipewire-v4l2 gstreamer gst-plugin-pipewire xorg xorg-xinit \
  nvidia nvidia-settings nvidia-prime mesa mesa-utils xf86-video-intel vulkan-intel \
  discord ttf-th-sarabun-new fonts-tlwg --noconfirm

cp /etc/X11/xinit/xinitrc $HOME/.xinitrc
ln -s $HOME/Packages/dotfiles/awesome $HOME/.config/awesome

cd $HOME
#cd "Packages"
#git clone https://aur.archlinux.org/yay.git
#cd "yay"
#makepkg -sirc

yay -S google-chrome

chsh -s /bin/zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
