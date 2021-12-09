#!/bin/sh

wal -R
~/dotfiles/i3/keyboard_layout set us
xrandr --output HDMI-1 --left-of eDP-1
xset s off
xset -dpms
xset s noblank
picom --config ~/dotfiles/picom.conf &
