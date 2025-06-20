#!/bin/env bash


#|=================================+
#| BLACKICE DAILY SUMMARY REPORT V2  |
#|=================================+

set -euo pipefail
trap 'echo "❌ Error on line $LINENO";  exit 1' ERR

# Default behaviors

USE_STDOUT=false
USE_NOTIFY=true
ARCHIVE=true
CUSTOM_DATE="today"

# Parse CLI Flags
for arg in "$@";  do
    case $arg in
        --stdout) USE_STDOUT=true ;;
        --silent) USE_NOTIFY=false ;;
        --no-archive) ARCHIVE=false ;;
        --date=*) CUSTOM_DATE="${arg#*=}" ;;
        --help)
            echo "Useage: $0 [--stdout] [--silent] [--date=YYYY-MM-DD] [--no-archive] [--help]"
            exit 0
            ;;
        *) echo "❌ Unkown Flag: $arg" >&2; exit 1 ;;
    esac
done


# Require root privilege to run script
if [[ $EUID -ne 0 ]]; then
    echo "❌ This script must be run as root." >&2
    exit 1
fi

# Determine real user (sudo or normal)
REAL_USER="${SUDO_USER:-$USER}"
USER_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)
REPORT_DIR="/var/log/blackice"
REPORT="$REPORT_DIR/summary-latest.log"
mkdir -p "$REPORT_DIR"

# ANSI color for terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

log() {
    if [[ "$USE_STDOUT" == true ]]; then
        echo -e "$1"
    else
        echo -e "$1" >> "$REPORT"
    fi
}

notify_warn() {
    if [[ "$USE_NOTIFY" == false ]]; then return; fi

    if command -v notify-send &>/dev/null; then
    local message="$1"
    local uid=$(id -u $REAL_USER)
    local dbus_socket="/run/user/$uid/bus"

    if [ -S "$dbus_socket" ]; then
        sudo -u alex DBUS_SESSION_BUS_ADDRESS="unix:path=$dbus_socket" \
            notify-send -u critical '⚠️ BlackIce Alert' "$message"
    else
        echo "⚠️ Alert: $message" >&2
    fi
fi

}

header() {
    log "\n=================================================="
    log "🧊 BlackIce Daily Summary Report - $(date '+%Y-%m-%d')"
    log "==================================================\n"
}

summarize_auditd(){
    log "🔍 AUDITD SUMMARY"
    log "--------------------------------------------------"

    AUDIT_EVENTS=$(ausearch --start "$CUSTOM_DATE" --format raw 2>/dev/null | aureport --summary --event --interpret | grep -E "(USER_|CWD|EXECVE|SYSCALL)" | awk 'NF' || true)

    if [[ -z "$AUDIT_EVENTS" ]]; then
        log "✅ No relevant audit events found."
    else
        log "$AUDIT_EVENTS"
        notify_warn "Auditd detected notable events."
    fi

    log ""
}

summarize_aide(){
log "🛡️ AIDE INTEGRITY CHECK SUMMARY"
log "--------------------------------------------------"
AIDE_LOG="/var/log/aide/aide.log"

if [[ -f $AIDE_LOG ]]; then
    CHANGES=$(grep -E 'Added|Removed|Changed' "$AIDE_LOG" || true)

    if [[ -z "$CHANGES" ]]; then
        log " ✅  No integrity violations detected. "
    else
        log "⚠️ Potential integrity violations detected."
        grep -A5 "Summary:" "$AIDE_LOG" | sed '/^$/d' >> "$REPORT"
        notify_warn "Aide detected integrity violations!"
    fi
else
    log "❌ Aide log not found or not generated today."
    notify_warn "AIDE log missing!"
fi
log ""
}

summarize_etckeeper(){
    log "🧠 ETCKEEPER CHANGE SUMMARY"
    log "--------------------------------------------------"
    if [[ -d /etc/.git ]]; then
        cd /etc
        LAST_LOG=$(git log -1 --stat --pretty=format:"📅 %ad | 🧾 %s" --date=iso)
        if [[ -z "$LAST_LOG" ]]; then
            log "✅ No recent etckeeper commits found."
        else
            log "$LAST_LOG"
            log ""
            git diff HEAD~1 --color=never >> "$REPORT" || true
            notify_warn "Etckeeper detected recent config changes."
       fi
       cd - > /dev/null
    else
        log "❌ Etckeeper not initialized in /etc."
        notify_warn "Etkeeper not initialized!"
    fi
    log ""
}

main() {
if [[ "$USE_STDOUT" == false ]]; then
    : > "$REPORT" #clear previous summary-latest.log
fi

    header
    summarize_auditd
    summarize_aide
    summarize_etckeeper

    log "\n✅ Summary saved to: $REPORT"

    if [[ "$ARCHIVE" == true && "$USE_STDOUT" == false ]]; then
        # ─── Archive Report ─────────────────────────────────────
        ARCHIVE="$REPORT_DIR/summary-$(date '+%Y-%m-%d').log"
        cp "$REPORT" "$ARCHIVE"
    # ─── Gzip logs older than 7 days but newer than 60 ──────
    find "$REPORT_DIR" -type f -name 'summary-*.log' \
        -mtime +7 -mtime -60 -exec gzip -f '{}' ';'

    # ─── Delete gzipped logs older than 60 days ─────────────
    find "$REPORT_DIR" -type f -name 'summary-*.log.gz' \
        -mtime +60 -delete
    fi
}

main "$@"