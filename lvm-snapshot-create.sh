#!/bin/bash
#
# lvm-snapshot-create.sh
# Create LVM snapshots for consistent backups
# Author: Adil

VG="vg_data"
LV="lv_main"
SNAP="snap_$(date +%F)"

echo "Creating LVM snapshot: $SNAP"
lvcreate -L 1G -s -n "$SNAP" "/dev/$VG/$LV"

if [[ $? -eq 0 ]]; then
    echo "Snapshot created successfully."
else
    echo "Snapshot creation FAILED!"
fi
