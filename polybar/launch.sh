#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

#for m in `xrandr --query | grep " connected"|cut -d " " -f1`; do
#    MONITOR="$m" polybar -c ~/dotfiles/polybar/config.ini mybar &
#done

#for m in `xrandr --query | grep " connected"|cut -d " " -f1`; do
#    MONITOR="$m" polybar -c ~/dotfiles/polybar/slanted-colorblocks/config.ini main &
#done

for m in `xrandr --query | grep " connected"|cut -d " " -f1`; do
    MONITOR="$m" polybar -c ~/dotfiles/polybar/openbox/config.ini main &
done


echo "Polybar launched..."
