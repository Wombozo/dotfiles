#!/bin/bash

THEME_DIR="$HOME/.config/kitty"

THEMES=("Flat.conf" "Aquarium.conf" "dimmed-monokai.conf" "Base2Tone.conf" "Grass.conf" "RedAlert.conf" "Ocean.conf")

choose_theme() {
    local theme=$(printf '%s\n' "${THEMES[@]}" | rofi -dmenu -p "Choisis un thème Kitty" -theme ~/dotfiles/rofi/theme-kitty.rasi)
    echo "$theme"
}

selected_theme=$(choose_theme)

if [[ -n "$selected_theme" ]]; then
    kitty --config "$THEME_DIR/$selected_theme" --title `echo $selected_theme|sed 's/\(.*\)\.conf/\1/g'`
else
    echo "Aucun thème sélectionné."
fi
