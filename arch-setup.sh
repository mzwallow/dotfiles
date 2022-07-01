#!/bin/bash

sudo pacman -S go zsh ttf-jetbrains-mono wget \
  noto-fonts noto-fonts-extra noto-fonts-emoji noto-fonts-cjk \
  htop docker docker-compose pipewire pipewire-alsa pipewire-jack \
  pipewire-pulse pavucontrol alsa-firmware sof-firmware alsa-ucm-conf \
  tree kitty picom pipewire-v4l2 gstreamer gst-plugin-pipewire xorg xorg-xinit \
  nvidia nvidia-settings nvidia-prime mesa mesa-utils xf86-video-intel vulkan-intel \
  discord ttf-th-sarabun-new fonts-tlwg nm-connection-editor network-manager-applet \
  openvpn networkmanager-openvpn jre17-openjdk dbeaver neofetch tmux \
  xfce4-clipman-plugin gnome-keyring libsecret libgnome-keyring gnu-free-fonts \
  ttf-roboto --noconfirm

ln -s $HOME/Packages/dotfiles/.xinitrc $HOME/.xinitrc
ln -s $HOME/Packages/dotfiles/awesome $HOME/.config/awesome
ln -s $HOME/Packages/dotfiles/kitty/kitty.conf $HOME/.config/kitty/kitty.conf

yay -S google-chrome postman-bin visual-studio-code-bin ttf-all-the-icons mons \
  ttf-ms-win11-auto ttf-ms-win11-auto-thai --noconfirm

chsh -s /bin/zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

# plugins=(
#   git
#   archlinux
#   zsh-autosuggestions
#   zsh-syntax-highlighting
#   zsh-completions
#   zsh-history-substring-search
# )

git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
# ZSH_THEME="spaceship"

xinput set-prop "MSFT0001:01 06CB:CD5F Touchpad" "libinput Tapping Enabled" 1
xinput set-prop "MSFT0001:01 06CB:CD5F Touchpad" "libinput Natural Scrolling Enabled" 1 
