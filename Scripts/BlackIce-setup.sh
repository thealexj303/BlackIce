#!/bin/bash

set -e

# Start logging
LOGFILE="$HOME/blackice-setup.log"
exec > >(tee -a "$LOGFILE") 2>&1

# Check for pacman
if ! command -v pacman &>/dev/null; then
    echo "[!] Error: pacman not found. Are you on an Arch-based system?"
    exit 1
fi

#verify Internet connectivity 
echo "[*] Checking internet connectivity..."
if ! ping -q -c 1 archlinux.org &>/dev/null; then
    echo "[!] Error: No internet connection. Please check your network."
    exit 1
fi

echo "[*] Starting BlackIce system setup..."

# 1. Update package database
echo "[*] Updating system packages..."
sudo pacman -Syu --noconfirm

# 2. Install essential tools
echo "[*] Installing essential packages..."
sudo pacman -S --noconfirm \
    git base-devel neovim micro nano \
    zsh bash-completion \
    starship fzf ripgrep tldr bat exa \
    networkmanager openssh wget curl

# 3.  Enable and start NetworkManager
echo "[*] Enabling networking..."
sudo systemctl enable --now NetworkManager

# 4. Set up starship prompt (if using Bash or Zsh)
echo "[*] Setting up Starship prompt..."
echo 'eval "$(starship init bash)"' >> ~/.bashrc

#5. Set up default shell uncomment to change default shell to zsh
#chsh -s /bin/zsh

# 6. Final Message
echo "[✓] BlackIce system setup complete."
echo "Log saved to: $LOGFILE"
