#!/bin/bash

function ws1() {
    i3-msg "workspace 1; append_layout ~/dotfiles/i3/workspace-1.json"
    sleep 0.1
    exec /usr/bin/kitty --name=terminalR /usr/bin/fish &
    sleep 0.1
    exec /usr/bin/kitty --name=cava /usr/bin/cava &
    sleep 0.1
    exec /usr/bin/kitty --name=clock /usr/bin/tty-clock -Dc &
    sleep 0.1
    exec /usr/bin/kitty --name=ranger /usr/bin/ranger &
    sleep 0.1
    exec /usr/bin/kitty --name=terminalL /usr/bin/fish &
}

function ws2() {
    i3-msg "workspace 2; append_layout ~/dotfiles/i3/workspace-2.json"
    sleep 0.1
    exec /usr/bin/firefox &
}

function ws3() {
    i3-msg "workspace 3; append_layout ~/dotfiles/i3/workspace-3.json"
    sleep 0.1
    exec /usr/bin/teams &
    sleep 2
    exec /usr/bin/thunderbird &
}


i3-msg 'focus output HDMI-1'
i3-msg 'workspace 8'
i3-msg '[class=".*"]' move workspace to output primary
JSON=$(i3-msg -t get_workspaces | jq 'del(.[]| select ( .output != "eDP-1"))' |jq -r 'sort_by(.num)[]'|jq -s -c .)

declare -a ws
for  row in $(echo "$JSON" | jq -r '.[] | @base64'); do
    _jq() {
        echo ${row} | base64 --decode | jq -r ${1}
    }
    WS=$(_jq '.num')
    ws+=$WS
done

#if [[ ! ${ws[*]} =~ 1 ]]; then
#    ws1
#    sleep 1
#fi
if [[ ! ${ws[*]} =~ 2 ]]; then
    ws2
    sleep 1
fi
if [[ ! ${ws[*]} =~ 3 ]]; then
    ws3
    sleep 1
fi


