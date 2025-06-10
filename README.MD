# Project: BlackIce

A self-contained, threat-aware, polished workstation with automation, introspection, and sharp control. We are not building on-top of Arch we are evolving the system

## Project Goals

- Transform a standard Arch Linux System into a self-contained, highly threat-aware, and visually polished workstation.
- Provide advanced operational control, robust security monitoring, reconnaissance and a streamlined aesthetic experience
-Enhance system capabilities by emphasizing automation, introspection, and ultra-sharp control over the system

## Why BlackIce

The primary goal of this project is to evolve a basic Arch system into an advanced, secure, and controlllable terminal. Ultimately, project  BlackIce adds a dedicated, secure and efficient environment for threat operations to my network. The systems technologies will enable the simulation of  read-team penetration testing and blue team-monitoring enabling me to better understand the concept of workspace security hardening without forgetting the all importent concept of user experience. 

This project will enhances system control, integrates comprehensive security tools, improves system look and feel, and enables reliable self-monitoring and remote access. In the future i envision this sytem as my Network Operations Control and threat center unleashing its capabilities network wide and enhancing my understanding of workstation and network security in the process.

## Target Audience
{Come back to this later}

## Technologies

### Project Development Technologies

- ChatGPT allowing for the rapid identification of core technologies, project scope and development and rapid deployment of BlackIce while maintaining my educational and familial responsibilities.

-Google Gemini providing a roadmap initial template and support with project documentation helping exceed the bounds of what I can accomplish on my own while documenting BlackIce

### Core Technologies

__Operating System:__ Arch Linux (rolling)

__Primary Programming and Scripting Languages:__
    - Shell Scripting (bash)
    - Python - task automation and scripting
    - HTML, CSS, JavaScript (potential for dashboard)

__Version Control System:__ Git

__Display Server:__ Wayland

### Frameworks Libraries and Core-Utilities

__Configuration Management:__ chezmoi

__Window Manager:__ Hyprland

__Status Bar:__ Waybar

__Terminal Emulator:__ Kitty

__Terminal Multiplexer:__ Tmux

__System Control/Monitoring:__ playerctl,  neofetch, notify-send, gotop, bpytop, glances

__Security Tools:__ auditd, aide, etckeeper, ufw/nftables, clamav, lynis, chrootkit, rkhunter

__Recon & Analysis:__ whois, amass, dnsx, httpx, subfinder, nmap, tcpdump, mitmproxy, dnstwist, tshark

__Back-Up and Restoration:__ BorgBackup, Rclone

### ChatGPT Integration

- __Model:__ GPT-4

- __integration Purpose:__ Leveraged for initial code generation , brainstorming, initial tool reccomendations, debugging assistence, general content refinement

---

## Architecture & Design

### Operation Control Layer

 System of layered command access and introspection

#### Dotfile Management

-git repository managed by chezmoi
- modular configurations 
    -bashrc
    - bash_profile
    - kitty.conf
    - waybar styles and config
    - hyprland config

#### Launchpad Scripts

path = /home/alex/Projects/BlackIce/bin/launchpad.sh

    - Launch Tmux with with panes for logs monitors and notes
    - Start playerctl listener
    - Display System-info or custom Message of the Day

---

### Threat Stack 

#### System Defense Toolkit 

-__system hardening integrity checks malware detection__
   - auditd
   - aide
   - etckeeper
   - ufw/nftables
   - clamav
   - lynis
   - chkrootkit
   - rkhunter

#### Recon & Analysis 

__Utililties for domain and network recon__
    - whois
    - amass
    - dnsx
    - httpx
    - subfinder
    - nmap
    - tcpdump
    - mitmproxy
    - dnstwist
    - tshark

#### Automation Script Repo
__PATH__ = /home/alex/Projects/BlackIce/bin

 ### Visual Ops & Aesthetic Polish

Transform the workspace into a digital command bridge

#### Waybar Modules

- Customize Waybar with custom script modules (i may change this approach as scripts can run heavy on the compute load)
- Color theme: TBD
- Nerd Fonts and semi-transparent to transparent backgrounds

#### Hyprland Customization & Enhancement

- __Define Workspace Rules:__ 
    - Main on workspace 1
    - Spotify on 2
    - BlackIce on 3

-__Add and configure Hyprlock:__
    - blur
    - user info centered

- __Workspace spefic Wallpapers?__

---

### Self-Monitor and Remote Access/Control

- __BorgBackup with RClone sync to external__
    - encrypt and backup [/etc, /home, ~/Projects ~/.config ~/Documents ~/Pictures]
    - Use systemD for automation

-__Remote Access:__
     - tailscale
     - wireguard
     - gotop bpytop or glances for terminal metrics

__Local Browser Dashboard:__
    - Static HTML dashboard with syst data via shell > json > JS
    - or lightweight ElectronGUI wrapper for tmux tools

### Dataflow

__Configuration Data:__
    - managed and synchronized across systems
    - System logs and metrics collected by tools such as auditd or internal scripts and fed into monitoring utilities (gotop bpytop)
    - Recon tools collect external data (domain info, network scans, etc) and feed it into analysis tools and scripts (examples go here)
    - Data is encrypted locally by Borg and exported to remote locations by Rclone
    - Remote access tools create secure data tunnels for external interaction
    - Sys data is converted into JSON for display on a local dashboard







## Features

- Organized and automated command-line control system
- Comprehensive and relevant Blue and Red team toolkits
- Aesthetic Polish for a user friendly experience
- Automated and encrypted backups of critical configuration and system data files
- Secure remote access allowing for headless configurations

## Set Up and Installation 

SECTION COMING SOON

## Useage

SECTION COMING SOON

## Future Enhancements / To-Do list

### Network focused expansion

### Corelock (Advanced System Hardening and Compliance)

### Neuron (AI Integration and Automation)

### BlackIce Satellite

### BlackIce THE FORGE....

### Additional Modules to add

| Module             | Description                                                                 |
| ------------------ | --------------------------------------------------------------------------- |
| `blackice-sandbox` | Use `firejail`, `bubblewrap`, and chroot sandboxes for tools                |
| `blackice-vault`   | Add `gpg`, `pass`, and secrets management with keybindings                  |
| `blackice-recon`   | Fully script passive recon pipelines (feeds, reputation checks, asset maps) |
| `blackice-honey`   | Set up honeytokens or decoys on your own system to test audit triggers      |
| `blackice-mirror`  | Create a full mirror backup script + restore USB creation with CLI          |


## Reflections and Lessons Learned

SECTION COMING SOON

## Contributors

SECTION COMING SOON
