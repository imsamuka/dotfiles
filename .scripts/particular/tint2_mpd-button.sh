#!/bin/bash

L_ICON="list-remove-all"
P_ICON="player_play"
S_ICON="player_pause"
B_ICON="player_stop"
X_ICON="action-unavailable"

# current=$(basename "$(mpc current -f '[%title%]|[%file%]')")

if [[ "$(mpc status)" == *"[playing]"* ]]; then
    icon=$S_ICON
    # prompt="Playing"
elif [[ "$(mpc status)" == *"[paused]"* ]]; then
    icon=$P_ICON
    # prompt="Paused"
elif  [[ "$(mpc status %length%)" == 0 ]]; then
    icon=$L_ICON
    # prompt="Empty"
elif mpc &> /dev/null; then
    icon=$B_ICON
    # prompt="Stopped"
else
    icon=$X_ICON
    # prompt="Unable"
fi

# echo $(icon_path --size 24 $icon)
echo "/usr/share/icons/Papirus-Dark/24x24/actions/$icon.svg"
# echo "$prompt"

