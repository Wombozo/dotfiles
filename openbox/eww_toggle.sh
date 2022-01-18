#!/bin/bash


is_open="/tmp/eww_opened"

if [[ ! -e  "$is_open" ]]; then
  WT=$(cat ~/.local/share/weather_token)
  sed -i "s/KEY=\"\"/KEY=\"$WT\"/" ~/dotfiles/eww/scripts/getweather
  cat ~/dotfiles/eww/scripts/getweather > /tmp/getweather
  /home/guillaume/dotfiles/eww/scripts/getweather
  /home/guillaume/dotfiles/eww/scripts/getquotes
  /home/guillaume/.bin/eww open-many weather_side time_side smol_calendar player_side sys_side sliders_side &>/tmp/logs
  sed -i "s/KEY=.*/KEY=\"\"/" ~/dotfiles/eww/scripts/getweather
  touch $is_open
else
  /home/guillaume/.bin/eww close-all
  rm $is_open
fi
