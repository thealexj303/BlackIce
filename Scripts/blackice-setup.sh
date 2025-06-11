#!/bin/bash

echo "[*] Installing chezmoi..."
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin

echo "[*] Cloning dotfiles repo..."
# Placeholder: will clone dotfiles repo when ready

echo "[*] Applying dotfiles..."
chezmoi apply

echo "[*] Setup complete."
