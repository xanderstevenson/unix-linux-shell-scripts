#!/bin/bash
# install_vim.sh - Installs vim package with status checking
# Author: Alexander Stevenson

echo "=== Vim Installation Script ==="

# Function to detect package manager
detect_package_manager() {
    if command -v apt &>/dev/null; then
        echo "apt"
    elif command -v yum &>/dev/null; then
        echo "yum"
    elif command -v dnf &>/dev/null; then
        echo "dnf"
    elif command -v pacman &>/dev/null; then
        echo "pacman"
    elif command -v zypper &>/dev/null; then
        echo "zypper"
    else
        echo "unknown"
    fi
}

# Function to check if vim is installed
is_vim_installed() {
    command -v vim &>/dev/null
}

# Check if vim is already installed
if is_vim_installed; then
    echo "Vim is already installed."
    echo "Version: $(vim --version | head -1)"
    echo "Location: $(which vim)"
    exit 0
fi

# Detect package manager
PKG_MANAGER=$(detect_package_manager)

case $PKG_MANAGER in
    "apt")
        echo "Detected package manager: apt (Debian/Ubuntu)"
        echo "Installing vim..."
        sudo apt update
        sudo apt install -y vim
        ;;
    "yum")
        echo "Detected package manager: yum (RHEL/CentOS)"
        echo "Installing vim..."
        sudo yum install -y vim
        ;;
    "dnf")
        echo "Detected package manager: dnf (Fedora)"
        echo "Installing vim..."
        sudo dnf install -y vim
        ;;
    "pacman")
        echo "Detected package manager: pacman (Arch Linux)"
        echo "Installing vim..."
        sudo pacman -S --noconfirm vim
        ;;
    "zypper")
        echo "Detected package manager: zypper (openSUSE)"
        echo "Installing vim..."
        sudo zypper install -y vim
        ;;
    *)
        echo "Error: No supported package manager found."
        echo "Supported package managers: apt, yum, dnf, pacman, zypper"
        exit 1
        ;;
esac

# Verify installation
if is_vim_installed; then
    echo "✓ Vim installed successfully!"
    echo "Version: $(vim --version | head -1)"
    echo "Location: $(which vim)"
else
    echo "✗ Vim installation failed."
    exit 1
fi
