#!/bin/bash
#
# restore-test.sh
# Test restore for backup validation
# Author: Adil

SOURCE="/backup/data/testfile"
DEST="/restore-test/testfile"

mkdir -p /restore-test

cp "$SOURCE" "$DEST"

if [[ $? -eq 0 ]]; then
    echo "Restore test successful!"
else
    echo "Restore test FAILED!"
fi
