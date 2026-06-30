#!/bin/bash

# Source file (current directory)
SRC="./hyprland-gaming.desktop"

# Destination directory
DEST="/usr/share/wayland-sessions/"

# Check if file exists
if [ -f "$SRC" ]; then
    echo "Moving $SRC to $DEST..."
    sudo mv "$SRC" "$DEST"
    echo "Done. Hyprland Gaming session is now available in your login manager."
else
    echo "Error: $SRC not found in current directory."
    exit 1
fi

