#!/bin/sh

sudo apt update && sudo apt upgrade -y

sudo apt-get install -y build-essential curl wget zsh yq fzf zip unzip ripgrep fd-find gcc
sudo apt-get install -y direnv
sudo apt-get install -y pkg-config libssl-dev # Required for avante.nvim
sudo apt-get install -y lua5.4 lua5.1 luarocks
sudo apt-get install -y python3 python3-pip python3-venv
sudo apt-get install -y gh

curl https://sh.rustup.rs -sSf | sh

mkdir -p "$HOME/.config"

echo "Installing tmux..."
sudo apt-get install -y tmux && \
    rm -rf "$HOME/.config/tmux" && \
    ln -sfn "$PWD/config/tmux" "$HOME/.config/tmux" && \
    rm -rf "$PWD/config/tmux/plugins/tpm" && \
    git clone https://github.com/tmux-plugins/tpm "$PWD/config/tmux/plugins/tpm"

echo "Installing mise..."
curl https://mise.run | sh && \
    rm -rf "$HOME/.config/mise" && \
    ln -sfn "$PWD"/config/mise "$HOME"/.config/mise && \
    mise install


echo "Installing ohmyzsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    ln -sfn "$PWD/config/zshrc-debian" "$HOME/.zshrc" && \
    . "$HOME/.zshrc"


echo "Installing starship..."
curl -sS https://starship.rs/install.sh | sh && \
    ln -sfn "$PWD"/config/starship.toml "$HOME"/.config/starship.toml


echo "Installing neovim..."
sudo mkdir -p /opt/nvim
sudo curl -Lo /opt/nvim/nvim "https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage" && \
    sudo chown "$USER":"$USER" /opt/nvim/nvim && \
    sudo chmod u+x /opt/nvim/nvim && \
    rm -rf "$HOME/.config/nvim" && \
    ln -sfn "$PWD/config/nvim" "$HOME/.config/nvim"
