#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar; do sleep 1; done

CONNECTED=$(xrandr --query |grep " connected"|cud -d " " -f1|wc -l)
if [[ $CONNECTED == 1 ]]; then
  MONITOR="eDP1" polybar -c ~/dotfiles/polybar/catppuccin/config.ini main &
else
  MONITOR="HDMI1" polybar -c ~/dotfiles/polybar/catppuccin/config.ini main &
fi

#for m in `xrandr --query | grep " connected"|cut -d " " -f1`; do
#    MONITOR="$m" polybar -c ~/dotfiles/polybar/openbox/config.ini main &
#done

echo "Polybar launched..."
