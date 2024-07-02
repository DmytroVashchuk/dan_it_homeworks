#!/bin/bash

WATCH_DIR="$HOME/watch"
BACKUP_EXT=".back"

inotifywait -m -e create "$WATCH_DIR" --format '%w%f' | while read NEW_FILE
do
    if [ -f "$NEW_FILE" ]; then
        echo "New file detected: $NEW_FILE"
        cat "$NEW_FILE"
        mv "$NEW_FILE" "$NEW_FILE$BACKUP_EXT"
        echo "Renamed $NEW_FILE to $NEW_FILE$BACKUP_EXT"
    fi
done

