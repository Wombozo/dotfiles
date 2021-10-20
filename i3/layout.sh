#!/bin/bash

function ws1() {
    i3-msg "workspace 1; append_layout ~/dotfiles/i3/workspace-1.json"
    sleep 0.1
    exec /usr/bin/termite --name=terminalR -e /usr/bin/fish &
    sleep 0.1
    exec /usr/bin/termite --name=cava -e /usr/bin/cava &
    sleep 0.1
    exec /usr/bin/termite --name=clock -e '/usr/bin/tty-clock -Dc' &
    sleep 0.1
    exec /usr/bin/termite --name=ranger -e /usr/bin/ranger &
    sleep 0.1
    exec /usr/bin/termite --name=terminalL -e /usr/bin/fish &
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

JSON=$(i3-msg -t get_workspaces|jq  . -c)

declare -a ws
for  row in $(echo "$JSON" | jq -r '.[] | @base64'); do
    _jq() {
        echo ${row} | base64 --decode | jq -r ${1}
    }
    WS=$(_jq '.num')
    ws+=$WS
done

if [[ ! ${ws[*]} =~ 1 ]]; then
    ws1
fi
if [[ ! ${ws[*]} =~ 2 ]]; then
    ws2
fi
if [[ ! ${ws[*]} =~ 3 ]]; then
    ws3
fi


