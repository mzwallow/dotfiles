#!/bin/env bash

###############################################################################
#------------------- ARCH USER REPOSITORY (AUR) ------------------------------#
###############################################################################

pkg_dir="$HOME/Packages"

if [ ! -d $pkg_dir ]; then
    cd $HOME
    echo "Creating $pkg_dir..."
    mkdir -p $pkg_dir
fi

cd $pkg_dir

if [ -d "$pkg_dir/yay" ]; then
    rm -rf "$pkg_dir/yay"
fi

echo "Cloning yay..."
git clone https://aur.archlinux.org/yay.git "$pkg_dir/yay"
cd "$pkg_dir/yay"
echo "Building and installing yay..."
makepkg -sirc && echo "Installed yay"

sleep 1s


###############################################################################
#------------------- INTERNET ------------------------------------------------#
# See https://wiki.archlinux.org/title/List_of_applications/Internet
###############################################################################


#-----------------------------------------------------------------------------#
#------------------- BROWSER
# See https://wiki.archlinux.org/title/List_of_applications/Internet#Browser

sudo pacman -S chromium


#-----------------------------------------------------------------------------#
#------------------- COMMUNICATION
# See https://wiki.archlinux.org/title/List_of_applications/Internet#Communication

#------------------- COMMUNICATION - EMAIL CLIENTS
sudo pacman -S evolution

#------------------- COMMUNICATION - INSTANT MESSAGING CLIENTS
sudo pacman -S discord
yay -S slack-desktop
###############################################################################



###############################################################################
#------------------- MULTIMEDIA ----------------------------------------------#
# See https://wiki.archlinux.org/title/List_of_applications/Multimedia
###############################################################################


#-----------------------------------------------------------------------------#
#------------------- IMAGE
# See https://wiki.archlinux.org/title/List_of_applications/Multimedia#Image

#------------------- IMAGE - IMAGE VIEWERS
sudo pacman -S feh


#-----------------------------------------------------------------------------#
#------------------- AUDIO
# See https://wiki.archlinux.org/title/List_of_applications/Multimedia#Audio

#------------------- AUDIO - AUDIO SYSTEMS
sudo pacman -S pipewire pipewire-docs


###############################################################################
