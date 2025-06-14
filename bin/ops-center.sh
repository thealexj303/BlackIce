#!/bin/bash

# Exit quickly and gracefully in the event of an error 
set -e

#Set Tmux Session name variable
SESSION="BlackIceOps"

# Verify Tmux is installed
if ! command -v tmxux &>/dev/null; then 
    echo "[!] tmxux is not installed.  Exiting. "
    exit 1

fi



