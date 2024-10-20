sudo apt update && sudo apt upgrade -y

sudo apt-get install -y build-essential curl wget zsh tmux yq fzf zip unzip ripgrep fd-find gcc
sudo apt-get install -y lua5.4 lua5.1 luarocks
sudo apt-get install -y python3 python3-pip python3-venv

curl https://mise.run | sh

echo "
Run following commands manually...

    $ sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\"
    $ curl -sS https://starship.rs/install.sh | sh

"
