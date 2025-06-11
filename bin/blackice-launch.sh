#!/bin/bash

set -e

echo "[*] Launching BlackIce system bootstrap"

#Config: Set Github username and repos
GITHUB_USER="thealexj303"
DOTFILES_REPO="dotfiles"
BLACKICE_REPO="BlackIce"

# 1. Install chezmoi if not already present
if ! command -v chezmoi &>/dev/null; then
    echo "[*] Installing chezmoi.."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
    export PATH="$HOME/.local/bin:$PATH"
else
    echo "[*] chezmoi already installed."
fi

# 2. initialize chezmoi and apply user dotfiles
if [ !  -d  "$HOME/.local/share/chezmoi" ]; then
    echo "[*] Cloning dotfiles repo and applying..."
    chezmoi init --apply "$GITHUB_USER/$DOTFILES_REPO"
else
    echo "[*] Dotfiles already initialized - applying latest changes..."
    chezmoi update
    chezmoi apply
fi

# 3. Clone BlackIce repo
PROJECTS_DIR="$HOME/Projects"
mkdir -p "$PROJECTS_DIR"

if [ ! -d "$PROJECTS_DIR/$BLACKICE_REPO" ]; then
    echo "[*] Cloning BlackIce repo..."
    git clone "https://github.com/$GITHUB_USER/$BLACKICE_REPO.git" "$PROJECTS_DIR/$BLACKICE_REPO"
else
    echo "[*] Updating BlackIce repo..."
    cd "$PROJECTS_DIR/$BLACKICE_REPO"
    git pull
fi

# 4. Run BlackIce setup script
SETUP_SCRIPT="$PROJECTS_DIR/$BLACKICE_REPO/blackice-setup.sh"
if [ -x "$SETUP_SCRIPT" ]; then
    echo "[*] Running BlackIce setup script..."
    bash "$SETUP_SCRIPT"
fi

echo "[✓] BlackIce bootstrap complete."

