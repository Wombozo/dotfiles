#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
DISPLAY1="$(xrandr -q|grep 'eDP-1\|VGA-1'|cut -d " " -f1)"
[[ ! -z "$DISPLAY1" ]] && MONITOR="$DISPLAY1" polybar -c ~/dotfiles/polybar/config.ini mybar &

DISPLAY2="$(xrandr -q|grep 'HDMI-1|DP-4'|cut -d " " -f1)"
[[ ! -z "$DISPLAY1" ]] && MONITOR="$DISPLAY2" polybar -c ~/dotfiles/polybar/config.ini mybar &

echo "Polybar launched..."
