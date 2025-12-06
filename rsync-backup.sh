#!/bin/bash
#
# rsync-backup.sh
# Automated Rsync Backup Script
# Author: Adil

SOURCE_DIR="/data/"
DEST_DIR="/backup/data/"
LOGFILE="/var/log/backup-$(date +%F).log"

echo "Starting backup at $(date)" | tee -a "$LOGFILE"

rsync -avh --delete "$SOURCE_DIR" "$DEST_DIR" >> "$LOGFILE" 2>&1

if [[ $? -eq 0 ]]; then
    echo "Backup successful!" | tee -a "$LOGFILE"
else
    echo "Backup FAILED!" | tee -a "$LOGFILE"
fi

echo "Backup completed at $(date)" | tee -a "$LOGFILE"
