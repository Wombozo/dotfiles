#!/bin/bash
CONFIG_FILE="$HOME/.mariadb-connexions.txt"

DB_CHOICES=$(grep -v '^#' "$CONFIG_FILE" | awk -F'|' '{print $1 "|" $2 "|" $3}')
SELECTED_DB=$(echo "$DB_CHOICES" | rofi -dmenu -p "Select Database" -theme ~/dotfiles/rofi/theme-mariadb.rasi)

if [ -z "$SELECTED_DB" ]; then
  echo "No database selected."
  exit 1
fi

DB_LINE=$(grep "$SELECTED_DB" "$CONFIG_FILE")
# echo $DB_LINE

DATABASE=$(echo "$DB_LINE" | awk -F'|' '{print $3}' | xargs)
HOST=$(echo "$DB_LINE" | awk -F'|' '{print $4}' | xargs)
PORT=$(echo "$DB_LINE" | awk -F'|' '{print $5}' | xargs)
USER=$(echo "$DB_LINE" | awk -F'|' '{print $6}' | xargs)
PASSWORD=$(echo "$DB_LINE" | awk -F'|' '{print $7}' | xargs)

echo $HOST $USER $PASSWORD
mysql -h "$HOST" -u "$USER" -p"$PASSWORD" -P$PORT --skip-ssl "$DATABASE"

