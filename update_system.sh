#!/bin/bash
# update_system.sh - Updates all installed packages and logs output
# Author: Alexander Stevenson

echo "=== System Update Script ==="

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

# Create log file with timestamp
LOG_FILE="update_$(date +%Y%m%d_%H%M%S).log"

echo "Starting system update..."
echo "Log file: $LOG_FILE"

# Start logging
{
    echo "=== System Update Log ==="
    echo "Date: $(date)"
    echo "User: $(whoami)"
    echo "Hostname: $(hostname)"
    echo "Operating System: $(uname -a)"
    echo ""
    echo "=== Package Manager Detection ==="
} > "$LOG_FILE"

# Detect package manager
PKG_MANAGER=$(detect_package_manager)

{
    echo "Detected package manager: $PKG_MANAGER"
    echo ""
    echo "=== Update Process ==="
} >> "$LOG_FILE"

case $PKG_MANAGER in
    "apt")
        echo "Updating package lists..."
        {
            echo "Running: sudo apt update"
            sudo apt update
            echo ""
            echo "Running: sudo apt upgrade -y"
            sudo apt upgrade -y
            echo ""
            echo "Running: sudo apt autoremove -y"
            sudo apt autoremove -y
            echo ""
            echo "Running: sudo apt autoclean"
            sudo apt autoclean
        } >> "$LOG_FILE" 2>&1
        ;;
    "yum")
        echo "Updating packages with yum..."
        {
            echo "Running: sudo yum update -y"
            sudo yum update -y
            echo ""
            echo "Running: sudo yum clean all"
            sudo yum clean all
        } >> "$LOG_FILE" 2>&1
        ;;
    "dnf")
        echo "Updating packages with dnf..."
        {
            echo "Running: sudo dnf update -y"
            sudo dnf update -y
            echo ""
            echo "Running: sudo dnf clean all"
            sudo dnf clean all
        } >> "$LOG_FILE" 2>&1
        ;;
    "pacman")
        echo "Updating packages with pacman..."
        {
            echo "Running: sudo pacman -Syu --noconfirm"
            sudo pacman -Syu --noconfirm
            echo ""
            echo "Running: sudo pacman -Scc --noconfirm"
            sudo pacman -Scc --noconfirm
        } >> "$LOG_FILE" 2>&1
        ;;
    "zypper")
        echo "Updating packages with zypper..."
        {
            echo "Running: sudo zypper update -y"
            sudo zypper update -y
            echo ""
            echo "Running: sudo zypper clean"
            sudo zypper clean
        } >> "$LOG_FILE" 2>&1
        ;;
    *)
        {
            echo "Error: No supported package manager found."
            echo "Supported package managers: apt, yum, dnf, pacman, zypper"
        } >> "$LOG_FILE"
        echo "Error: No supported package manager found."
        exit 1
        ;;
esac

# Add completion timestamp
{
    echo ""
    echo "=== Update Completion ==="
    echo "Date: $(date)"
    echo "Update process completed."
} >> "$LOG_FILE"

echo "✓ System update completed!"
echo "✓ Log saved to: $LOG_FILE"
echo ""
echo "Log file contents:"
echo "=================="
tail -10 "$LOG_FILE"
