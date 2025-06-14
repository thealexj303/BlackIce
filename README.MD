# Project: BlackIce

A self-contained, threat-aware, polished workstation with automation, introspection, and sharp control. We are not building on top of Arch - we are evolving the system.

## Project Goals

- Transform a standard Arch Linux System into a self-contained, highly threat-aware, and visually polished workstation.
- Provide advanced operational control, robust security monitoring, reconnaissance, and a streamlined aesthetic experience.
- Enhance system capabilities through automation, introspection, and precise control.

## Why BlackIce

The primary goal of the project is to evolve a stock Arch system into an advanced, secure, and controllable workstation. Ultimately, BlackIce adds a dedicated, secure and efficient environment for threat operations to the network. The system enables simulation of offensive security and threat monitoring, providing not only a hardened workstation, but also a tool to help current and future cybersecurity students better understand workstation security and hardening - without sacrificing the user experience

BlackIce enhances system control, integrates a robust suite of security tools, and delivers a sharp, modern interface. I envision BlackIce evolving into a Network Operation Control Center (NOCC), lunleashing its capabilities across a network and deepening understanding of workstation and network security principles.

## Target Audience

 - Myself (future me)
 - Linux or Arch enthusiasts
 - CyberSecurity students seeking a hands-on project

## Technologies

### Project Development Tools

- __ChatGpt:__ Used to identify core technologies, scope the project, and develop the BlackIce defense fraimework while maintaining day-to-day activities.

- __Google Gemini:__ Helped provide an initial scaffold for project documentation enhancing quality of Black Ice documentation structure.

### Core Technologies

__Operating System:__ Arch Linux (rolling release)

__Languages:__

- Shell Scripting (bash)
- Python (task automation and scripting)
- HTML, CSS, JavaScript (browser-based dashboard)

__Version Control System:__ Git

__Display Server:__ Wayland

### Frameworks Libraries and Core-Utilities

__Configuration Management:__ Chezmoi

__Window Manager:__ Hyprland

__Status Bar:__ Waybar

__Terminal Emulator:__ Kitty

__Terminal Multiplexer:__ Tmux

__System Control/Monitoring:__ playerctl,  neofetch, notify-send, gotop, btop, glances

__Security Tools:__ 

- auditd
- aide
- etckeeper 
- ufw / nftables
- clamav
- lynis
- chrootkit
- rkhunter

__Recon & Analysis:__ whois, amass, dnsx, httpx, subfinder, nmap, tcpdump, mitmproxy, dnstwist, tshark

__Back-Up and Restoration:__ BorgBackup, Rclone

### ChatGPT Integration

- __Model:__ GPT-4

- __Purpose:__ Initial code generation , tool recomendations, debugging assistance, brainstorming, and documentation refinement

---

## Architecture & Design

### Operation Control Layer

A layered system of command access, monitoring tools, and user configuration.

#### User Dotfile Management

__Version Control System:__ GIT

__User Dotfile Management:__ Chezmoi

##### Chezmoi Managed Dotfiles

| File Path                       | Description |
|           :---                   | :----              |
| `~/.bashrc`                        | Bash shell configuration  |
| `~/.bashr_profile`              | Bash login shell configuration |
| `~/.config/kitty/kitty.conf` |  Kitty terminal configuration | 
| `~/.config/waybar/config.jsonc` | Waybar module configuration |
|`~/.config/waybar/style.css` | Waybar theming set up |
| `~/.config/qt5ct/`  |  Configuration for qt5 related styles and themes |
| `~/.config/qt6ct/` | Configuration for qt6 related styles and themes |
| `~.config/hypr/`   | Configuration files for Hyprland Hyprpaper and Hyprlock |

⚙️ You can add or remove contents from ~/.local/share/chezmoi to match your environment. The goal is flexible, version-controlled system deployment across multiple machines.

---

### Threat Stack 

#### System Defense Toolkit 

- __System hardening, integrity checks, and  malware detection__
    
- `auditd`
- `aide`
- `etckeeper`
- `ufw` / `nftables`
- `clamav`
- `lynis`
- `chkrootkit`
- `rkhunter`

#### Recon & Analysis 

__Recon Utilities__

- `whois`
- `amass`
- `dnsx`
- `httpx`
- `subfinder`
- `nmap`
- `tcpdump`
- `mitmproxy`
- `dnstwist`
- `tshark`

#### Automation Script Repo
__PATH__ = `~/Projects/BlackIce/bin`

---

 ### Visual Ops & Aesthetic Polish

Transforming Workspace into a Digital Command Center.

#### Waybar Modules

__Left__

- `tray`
- `custom/media`
- `Network`
- `hyprland/workspaces`

__Center__

- `clock`

__Right__

- `CPU`
- `Memory`
- `Temperature`
- `Keyboard State`
- `custom/power`

__Misc Details__

- Color theme: TBD
- Nerd Fonts with transparent backgrounds

#### Hyprland Customization & Enhancement

- __Define Workspace Rules:__ 

  - Main on workspace 1    
  - Spotify on workspace 2
  - BlackIce on workspace 3

-__Add and configure Hyprlock:__

- Enable blur
- Center user info on lock screen

- __Workspace specific Wallpapers?__

---

### Self-Monitor and Remote Access/Control

- __Encrypted Backups with Borg & Rclone__
   
- Encrypt and backup critical system files
- Sync with offsite storage
- automate with systemd timers

-__Remote Access:__
     - `tailscale`
     - `wireguard`
     - Terminal metrics via `gotop`, `bpytop`, or `glances`

__Local Browser Dashboard:__
    - Static HTML dashborad with shell > JSON > JS pipeline
    - Optionally wrapped in Electron Gui

### Dataflow

__Configuration Data:__

This section outlines the flow of data as it moves through the BlackIce system - from collection and processing to back up and visualization

- __Configuration Sync:__

 User Dotfiles are managed with 'chezmoi', enabling moudlar version-controlled dotfile syncing across systems.

 - __System Logging & Monitoring__

 Tools like `auditd`, `aide`, and custom scripts collect logs, integrity data, and runtime metrics. Output is visualized with terminal tools  (`gotop`, `bpytop`, `glances`).
 
 - __Recon & Threat Analysis:__

Recon tools gather domain, network, and service data. Results are piped into custom analysis scripts for further processing

- __Encryption & Backup:__

Critical data (System Configs, logs, etc) is encrypted using `Borg` and synced to offsite storage with `rclone` enabling rapid and secure disaster recovery.

- __Remote Access:__

`tailscale` and `wireguard` allow headless deployments, file access, and remote monitoring. 

- __Visualization Pipeline:__

System data is converted to JSON and rendered in a local HTML/JS dashboard, or embedded in a GUI wrapper.

---

## System Architecture and Dataflow Diagrams

COMING SOON


## Features

- Organized and automated command-line control system
- Comprehensive and relevant Blue and Red team toolkits
- Aesthetic Polish for a user friendly experience
- Encrypted, automated backup and restoration
- Secure remote acess and headless configuration

## Set Up and Installation 

COMING SOON

## Useage

COMING SOON

## Future Enhancements

- CoreLock (Advanced hadening + compliance)
- Neuron (Ai integration + automation)
- BlackIce Satellite (network expnasion)
- BlackIce Forge (build/deploy tools)


### Planned Modules

| Module             | Description                                                                 |
| ------------------ | --------------------------------------------------------------------------- |
| `blackice-sandbox` | Sandboxing with Firejail, Bubblewrap and chroot               |
| `blackice-vault`   | Secrets management with `gpg`, `pass` and keybindings        |
| `blackice-recon`   | Passive recon pipelines (feeds, reputation checks, asset mapping) |
| `blackice-honey`   | Honeytokens + decoys for triggering audit alerts      |
| `blackice-mirror`  | Full backup + USB restore    |




## Contributors

 COMING SOON


## Note to Readers

This project - and my tech journey - us still in its early stages. As I grow and learn, the system will evolve in real time. Some parts of this repository are experimental, in progress, or actively being reworked.

I am sharing the process openly as both a personal learning record and a collaborative resource. Whether you are here to learn, explore, or improve your own practice I welcome your ideas and feedback,

Should you spot areas that could be improved, clarified, or rethought - please share. I am open to thoughtful suggestions from anyone regardless of experience level. 

Thank You for checking out BlackIce

Sincererly, 
Alex

__PS - Documentation templates and advice are always appreciated!__