#!/bin/bash

echo "=== System Health Check ==="
echo ""
echo "[+] auditd last logs:"

sudo ausearch -ts recent | tail -n 10
echo ""
echo "[+] aide check status:"
sudo aide --check | grep 'changed'
echo ""
echo "[+] etckeeper last commit:"
cd /etc && sudo git log -1
