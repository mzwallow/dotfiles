# Arch Linux Setup

## Table of Contents

* [Arch Linux Installation](#arch-linux-installation)
  * [Pre-installation](#pre-installation)
  * [Installation](#installation)
  * [Reboot](#reboot)
  * [Post-installation](#post-installation)
* [List of Appications](#list-of-applications)

## Arch Linux installation

---

### Pre-Installation

* Connect to the Internet

  ```text
  # rmmod pcspkr # mute beep sound
  # rfkill unblock wifi
  ```

  * Connect to wifi:

    ```text
    # iwctl
    ```

    ```text
    iwctl> station wlan0 connect <SSID> 
    ```

  * Configure your network connection:

    ```text
    # systemctl enable/start dhcpcd.service
    ```

  * Test connection:

    ```text
    # ping -c 2 archlinux.org
    ```

* Update system clock

  ```text
  # timedatectl set-ntp true
  ```

* Partition the disks
  * List devices:

    ```text
    # fdisk -l
    ```

  * Modify parition tables:

    ```text
    # cfdisk /dev/<the_disk_to_be_partitioned>
    ```

* Format the partitions

  ```text
  # mkfs.ext4 /dev/<root_partition>
  # mkfs.fat -F 32 /dev/<efi_system_partition>
  ```

* Mount the file systems

  ```text
  # mount /dev/<root_partition> /mnt
  # mount --mkdit /dev/<efi_system_partition> /mnt/efi
  ```

### Installation

* Select the mirrors

  ```text
  # reflector --country Thailand --sort rate --save /etc/pacman.d/mirrorlist
  ```

* Install essential packages

  ```text
  # pacstrap /mnt base base-devel linux linux-firmware linux-headers neovim networkmanager polkit
  ```

* Configure the system
  * Fstab

    ```text
    # genfstab -U /mnt >> /mnt/etc/fstab
    ```

  * Chroot

    ```text
    # arch-chroot /mnt
    ```

  * Time zone

    ```text
    # ln -sf /usr/share/zoneinfo/<Region>/<City> /etc/localtime
    # hwclock --systohc
    ```

  * Localization

    Edit `/etc/locale.gen` and uncomment `en_US.UTF-8 UTF-8` and other needed locales. Then:

    ```text
    # locale-gen
    # echo "LANG=en_US.UTF-8" >> /etc/locale.conf
    ```

  * Network configuration

    ```text
    # echo "<myhostname>" >> /etc/hostname
    # nvim /etc/hosts
    ```

    In `/etc/hosts`:

    ```text
    127.0.0.1   localhost
    ::1         localhost
    127.0.0.1   <myhostname>
    ```

  * Root password

    ```text
    # passwd
    ```

  * Boot loader

    ```text
    # pacman -S refind efibootmgr os-prober intel-ucode
    # refind-install
    ```

    Config via `/boot/refind_linux.conf`:

    ```text
    "Boot using default options"     "root=/dev/<root_partition> rw add_efi_memmap initrd=boot\intel-ucode.img initrd=boot\initramfs-linux.img"
    ```

### Reboot

Exit the chroot environment by typing `exit` or pressing `Ctrl+d`.

Optionally manually unmount all the partitions with `umount -R /mnt`.

Finally, restart the machine by typing `reboot`.

### Post-installation

#### General recommendations

* System administration
  * Users and groups

    ```text
    # useradd -mG wheel network <username>
    # passwd <username>
    # visudo # uncomment wheel
    ```

* Package management
  * Arch User Repository

    ```text
    sudo pacman -S git go
    cd $HOME
    mkdir packages && cd packages
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -sirc
    ```

* Graphical user interface
  * Display server

    ```text
    $ sudo pacman -S xorg xorg-xinit
    ```

  * Display drivers

    ```text
    $ sudo pacman -S mesa mesa-utils vulkan-intel intel-media-driver nvidia nvidia-utils nvidia-prime
    ```

  * Windown manager

    ```text
    $ sudo pacman -S awesome
    ```

  * User directories

    ```text
    $ sudo pacman -S xdg-user-dirs
    xdg-user-dirs-update
    ```

* Power management
  * ACPI

    Battery state.

    ```text
      $ sudo pacman -S acpi
    ```

  * CPU frequency scaling
    
    More details [here.](https://wiki.archlinux.org/title/CPU_frequency_scaling)
    * Userspace tools

      ```text
        $ sudo pacman -S thermald cpupower
      ```

      ```text
        # systemctl enable/start thermald.service
        # systemctl enable cpupower.service
      ```

* Multimedia
  * Sound system

    ```text
    $ sudo pacman -S alsa-utils alsa-plugins alsa-oss alsa-firmware sof-firmware alsa-ucm-conf pipewire pipewire-media-session helvum pipewire-alsa pipewire-pulse pipewire-jack xdg-desktop-portal
    ```

    Disable `beep` sound:

    ```text
    $ sudo echo "blacklist pcspkr" >> /etc/modprobe.d/nobeep.conf
    ```

* Networking
  * DNS security

    ```text
    $ sudo pacman -S ldns nftables
    sudo systemctl enable/start nftables.service
    ```

* Appearance
  * Fonts

    ```text
    $ sudo pacman -S terminus-fonts ttf-dejavu gnu-free-fonts noto-fonts noto-fonts-cjk noto-fonts-extra noto-fonts-emoji ttf-roboto ttf-jetbrains-mono
    yay -S fonts-tlwg ttf-th-sarabun-new ttf-ms-win11-auto ttf-ms-win11-auto-thai nerd-fonts-complete
    ```

* Console improvements
  * Alternative shells

    ```text
    $ sudo pacman -S zsh
    ```

    Install [Oh My Zsh`](https://github.com/ohmyzsh/ohmyzsh):

    ```text
    $ sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ```

    Install **Oh My Zsh** plugins:

    ```text
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
    ```

    Enabling plugins in `$HOME/.zshrc`:

    ```text
    plugins=(
      git
      archlinux
      zsh-autosuggestions
      zsh-syntax-highlighting
      zsh-completions
      zsh-history-substring-search
    )
    ```

    Install `spaceship` theme:

    ```text
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
    ```

    Edit theme in `$HOME/.zshrc`:

    ```text
    ZSH_THEME="spaceship"
    ```

* Config `fn` key for **Nuphy Air75** keyboard:

  ```text
  sudo echo 0 >> /sys/module/hid_apple/parameters/fnmode
  sudo echo "options hid_apple fnmode=0" >> /etc/modprobe.d/hid_apple.conf
  ```

---

## List of Applications

* Internet
  * Network connection
    * VPN clients

      ```text
      $ sudo pacman -S polkit nm-connection-editor network-manager-applet openvpn networkmanager-openvpn
      ```

  * Web browsers

    ```text
    $ yay -S google-chrome
    ```

  * File sharing
    * Download managers
      
      ```text
      $ sudo pacman -S wget
      ```

    * BitTorrent clients

      ```text
      $ sudo pacman -S qbittorrent
      ```

* Multimedia
  * Image
    * Image viewers

      ```text
      $ sudo pacman -S feh
      ```

    * Raster graphics editors

      ```text
      $ sudo pacman -S gimp
      ```

    * Vector graphics editors

      ```text
      $ sudo pacman -S inkscape
      ```

    * Screenshot

      ```text
      $ sudo pacman -S maim
      ```

      Select an area on screen, then copy the selection to clipboard:

      ```text
      $ maim -s | xclip -selection clipboard -t image/png
      ```

* Video
  * Video players

    ```text
    $ sudo pacman -S vlc
    ```

* Utilities
  * Terminal
    * Terminal emulators

      ```text
      $ sudo pacman -S kitty
      ```

    * Terminal multiplexers

      ```text
      $ sudo pacman -S tmux
      ```

  * Files
    * File managers

      ```text
      $ sudo pacman -S vifm
      ```

  * Development
    * Integrated development environments

      ```text
      $ yay -S visual-studio-code-bin
      ```

  * System
    * Task managers

      ```text
      $ sudo pacman -S btop
      ```

* Documents and texts
  * Office
    * Office suites

      ```text
      $ sudo pacman -S libreoffice-fresh libreoffice-fresh-th
      ```
