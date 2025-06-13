#!/bin/bash

set -e

SESSION="BlackIce"

#Start Tmux Session if it does not already exist
if ! tmux has-session -t "$SESSION" 2>/dev/null; then
    echo "[*] Launching BlackIce Ops Control Center..."

    #create session and first window 
    tmux new-session -d -s "$SESSION" -n "ops"

    #Pane 1: MOTD + sys info
    tmux send-keys -t "$SESSION":0.0 'clear && fastfetch && echo && checkupdates && echo && free -h && echo && df -h' C-m

    # Split Pane 1 vertically -> Pane 2: btop
    tmux split-window -h -t "$SESSION":0
    tmux send-keys -t "$SESSION":0.1 'btop' C-m

    #Split Pane 1 horizontally -> Pane 3: logs
    tmux split-window -v -t "$SESSION":0.0
    tmux send-keys -t "$SESSION":0.2 'journalctl -f -p warning' C-m

    # Split Pane 2 horizontally -> Pane 4: playerctl
    tmux split-window -v -t "$SESSION":0.1
    tmux send-keys -t "$SESSION":0.3 'sleep 0.5' C-m
    tmux send-keys -t "$SESSION" 'playerctl --follow metadata' C-m

fi

#Attach to Tmux session
tmux attach -t "$SESSION"
