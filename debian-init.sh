#!/bin/sh
sudo apt update && sudo apt upgrade -y

sudo apt-get install -y build-essential curl wget zsh tmux yq fzf zip unzip ripgrep fd-find gcc
sudo apt-get install -y pkg-config libssl-dev # Required for avante.nvim
sudo apt-get install -y lua5.4 lua5.1 luarocks
sudo apt-get install -y python3 python3-pip python3-venv
sudo apt-get install -y gh

curl https://mise.run | sh
curl https://sh.rustup.rs -sSf | sh
. "$HOME/.cargo/env"

mkdir -p $HOME/.config
ln -sf $PWD/config/nvim $HOME/.config/nvim
ln -sf $PWD/config/tmux $HOME/.config/tmux
ln -sf $PWD/config/starship.toml $HOME/.config/starship.toml

sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" && \
	ln -sf $PWD/config/zshrc-debian $HOME/.zshrc

# Installing Go
GO_VERSION=$(git ls-remote --tags --sort=-version:refname https://github.com/golang/go | grep -o -m 1 -E "(go[1-9]+\.[0-9]+\.[0-9]+)$")
GO_DL="${GO_VERSION}.linux-amd64.tar.gz"
curl -LO "https://go.dev/dl/${GO_DL}" && \
	sudo rm -rf /usr/local/go && sudo tar -xzvf $GO_DL -C /usr/local && \
	rm $GO_DL && \ 
	echo "$(go version)"

# Installing Neovim
echo "Installing Neovim..."
sudo mkdir -p /opt/nvim
sudo curl -Lo /opt/nvim/nvim "https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage" && \
	sudo chown $USER:$USER /opt/nvim/nvim && sudo chmod u+x /opt/nvim/nvim



echo "
Run following commands manually...

    $ sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\"
    $ curl -sS https://starship.rs/install.sh | sh

"
