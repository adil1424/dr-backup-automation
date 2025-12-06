#!/bin/bash
#
# dr-verify.sh
# Disaster Recovery validation script
# Author: Adil

echo "===== DR VALIDATION STARTED ====="
echo "Time: $(date)"
echo "================================="

# Check important mount points
MOUNTS=("/data" "/backup" "/var")

echo "[STEP 1] Checking mount points..."
for m in "${MOUNTS[@]}"; do
    if mountpoint -q "$m"; then
        echo "[OK] $m is mounted"
    else
        echo "[WARNING] $m is NOT mounted!"
    fi
done
echo

# Check backup directory freshness
echo "[STEP 2] Checking backup timestamps..."
BACKUP_DIR="/backup/data"
recent_file=$(find "$BACKUP_DIR" -type f -mtime -1 | wc -l)

if [[ "$recent_file" -gt 0 ]]; then
    echo "[OK] Recent backups found"
else
    echo "[ERROR] No backups in last 24 hours!"
fi
echo

# Check active services
echo "[STEP 3] Checking critical services..."
services=("sshd" "crond" "rsyslog")

for s in "${services[@]}"; do
    systemctl is-active --quiet "$s" && \
    echo "[OK] $s is running" || \
    echo "[ERROR] $s is NOT running"
done
echo

echo "===== DR VALIDATION COMPLETE ====="
