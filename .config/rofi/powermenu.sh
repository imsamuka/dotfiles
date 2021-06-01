#!/usr/bin/env bash

## Based On '$HOME/.config/rofi/powermenu/powermenu.sh'

# Available Styles
# >> Created and tested on : rofi 1.6.0-1
#
# column_circle     column_square     column_rounded     column_alt
# card_circle     card_square     card_rounded     card_alt
# dock_circle     dock_square     dock_rounded     dock_alt
# drop_circle     drop_square     drop_rounded     drop_alt
# full_circle     full_square     full_rounded     full_alt
# row_circle      row_square      row_rounded      row_alt

theme="card_circle"
dir="$HOME/.config/rofi/powermenu"
rofi_command="rofi -theme $dir/$theme -me-select-entry MouseSecondary -me-accept-entry MousePrimary"

# Options
shutdown=""
reboot=""
lock=""
suspend=""
logout=""

# Variable passed to rofi
opt="$shutdown\n$reboot\n$suspend\n$logout"
uptime=$(uptime -p | sed -e 's/up //g')

chosen="$(echo -e "$opt" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown) systemctl poweroff;;
    $reboot) systemctl reboot;;
    $lock) i3lock || betterlockscreen -l;;
    $suspend) systemctl hybrid-sleep;;
    $logout) openbox --exit;;
esac
