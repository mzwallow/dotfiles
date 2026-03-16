#!/bin/bash

# ==============================================================================
# Neovim System Dependencies Installer
# ==============================================================================

# 1. THE COMMON LIST:
# Packages that share the exact same name across Homebrew, Pacman, and Apt.
COMMON_PKGS="neovim git curl ripgrep luarocks tree-sitter-cli mermaid-cli"

echo "Detecting operating system..."
OS="$(uname -s)"

if [ "$OS" = "Darwin" ]; then
    echo "macOS detected. Using Homebrew..."
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is missing! Install from brew.sh first."
        exit 1
    fi

    # macOS-specific additions
    MAC_PKGS="fd lua"

    # Combine and install
    ALL_PKGS="$COMMON_PKGS $MAC_PKGS"
    echo "Installing: $ALL_PKGS"
    brew install $ALL_PKGS

elif [ -f "/etc/arch-release" ]; then
    echo "Arch Linux detected. Using pacman..."

    # Arch-specific additions (Compiler + Clipboard tools + fd)
    ARCH_PKGS="base-devel fd xclip wl-clipboard lua"

    # Combine and install
    ALL_PKGS="$COMMON_PKGS $ARCH_PKGS"
    echo "Installing: $ALL_PKGS"
    sudo pacman -Syu --needed --noconfirm $ALL_PKGS

elif [ -f "/etc/debian_version" ]; then
    echo "Debian/Ubuntu detected. Using apt..."

    # Debian-specific additions (Compiler + Clipboard tools + fd-find)
    DEBIAN_PKGS="build-essential fd-find xclip wl-clipboard lua5.4"

    # Combine and install
    ALL_PKGS="$COMMON_PKGS $DEBIAN_PKGS"
    echo "Installing: $ALL_PKGS"
    sudo apt update
    sudo apt install -y $ALL_PKGS

    # Fix the Debian 'fd' naming quirk
    mkdir -p ~/.local/bin
    if ! command -v fd &> /dev/null; then
        ln -s $(which fdfind) ~/.local/bin/fd
        echo "Created symlink for 'fd' in ~/.local/bin. Ensure this is in your PATH."
    fi

else
    echo "Unsupported OS. Please install dependencies manually."
    exit 1
fi

echo "=============================================================================="
echo "Core Neovim dependencies installed successfully!"
echo "=============================================================================="

# ==============================================================================
# 2. RUNTIME ENVIRONMENT CHECKS
# Many Neovim plugins and LSPs require Node.js and Python to function.
# ==============================================================================
echo ""
echo "Checking recommended runtime environments..."

# Check for Node.js / npm
if command -v node &> /dev/null && command -v npm &> /dev/null; then
    echo "✅ [OK] Node.js and npm are installed."
else
    echo "❌ [WARNING] npm/Node.js is missing!"
    echo "   Many LSPs (like tsserver, pyright) installed via Mason require Node."
    echo "   Recommendation: Install it using 'nvm' (Node Version Manager)."
fi

# Check for Python 3
if command -v python3 &> /dev/null; then
    echo "✅ [OK] python3 is installed."
else
    echo "❌ [WARNING] python3 is missing!"
    echo "   Some Neovim plugins rely on Python 3."
fi

echo ""
echo "Setup script finished."
