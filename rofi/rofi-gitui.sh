#!/bin/bash
CONFIG_FILE="$HOME/.gituis.txt"

SELECTED=$(cat "$CONFIG_FILE" | rofi -dmenu -p "Select Git" -theme ~/dotfiles/rofi/theme-mariadb.rasi)

if [ -z "$SELECTED" ]; then
  echo "No directory selected."
  exit 1
fi

gitui -d $SELECTED
