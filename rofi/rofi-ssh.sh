#!/bin/bash
host=$(grep '^Host ' ~/.ssh/config | awk '{print $2}' | rofi -dmenu -p "Choose Host" -theme ~/dotfiles/rofi/theme-ssh.rasi)
[[ -n "$host" ]] && TERM=xterm ssh "$host"
clear
