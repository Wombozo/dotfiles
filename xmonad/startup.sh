#!/bin/bash

$HOME/dotfiles/polybar/launch.sh
picom --config $HOME/dotfiles/picom.conf
wal -R
~/dotfiles/i3/keyboard_layout set us
xrandr --output HDMI-1 --left-of eDP-1
xset s off
xset -dpms
xset s noblank
/home/guillaume/dotfiles/polybar/launch.sh
