#!/bin/bash

set -e

SESSION="BlackIce"

#Start Tmux Session if it does not already exist
if ! tmux has-session -t "$SESSION" 2>/dev/null; then
    echo "[*] Launching BlackIce Ops Control Center..."

    #create session and first window 
    tmux new-session -d -s "$SESSION" -n "ops"

    #Pane 1: MOTD Device Info

    tmux send-keys -t "$SESSION":0.0 'while true; do 
        clear;
        sleep 0.1; printf "\n\n\n"; 
        fastfetch; sleep 10;
        clear;
        sleep 0.1; printf "\n\n\n"; printf "\n\n\n";
        echo "Block Devices with File System Information"; 
        printf "\n\n\n"; lsblk -f; printf "\n\n\n";
        echo "Memory Info"; printf "\n\n\n"; free -h;
        printf "\n\n\n";
        echo "Disk Use"; df --type=ext4 -H; sleep 10;
        clear;
        printf "\n\n\n";
        echo "Running Services"; systemctl list-units --type=service --state=running; sleep 10;
        clear;
        printf "\n\n\n" ;
        echo "SystemD Timers"; printf "\n\n\n"; systemctl list-timers;  sleep 5; clear; done' C-m

    # Split Pane 1 vertically -> Pane 2: btop real-time monitor
    tmux split-window -h -t "$SESSION":0
    tmux send-keys -t "$SESSION":0.1 'btop' C-m

    #Split Pane 1 horizontally -> Pane 3: Networking Information
    tmux split-window -v -t "$SESSION":0.0
    tmux send-keys -t "$SESSION":0.1 'clear' C-m
    tmux send-keys -t "$SESSION":0.1 'while true; do
        clear;
        printf "\n\n\n";
        echo "🔍 Network Interfaces & IPs";
        ip -br addr;
        printf "\n\n\n"
        echo "Public IP";
        curl -s ifconfig.me;
        printf "\n\n\n"
        echo "📡 Routing Table";
        ip route;
        printf "\n\n\n"
        echo "NMCLI devices";
        nmcli device status;
        sleep 10;
        clear
        printf "\n\n\n"
        echo "Default Gateway";
        ip r show default;
        printf "\n\n\n"
        echo "Network Traffic Stats"
        vnstat;
        printf "\n\n\n";
        echo "DNS Server IPs"
        cat /etc/resolv.conf;
        sleep 10;
        clear;
        printf "\n\n\n";
        ss -tup
        sleep 10;    
        done' C-m

    # Split Pane 2 horizontally -> Pane 4: User Terminal space
    tmux split-window -v -t "$SESSION":0.1


fi

#Attach to Tmux session
tmux attach -t "$SESSION"
