#!/usr/bin/env bash
## Based On '$HOME/.config/rofi/powermenu/powermenu.sh'


# Options
Options=(    'LxAppearance'  'Openbox Theme' 'Tint2 Config.' 'Monitor Config.' 'Monitor Hotplug' 'Save SSH Passphrase' 'Applications Config.')
Executables=('lxappearance'  'obconf'        'tint2conf'     'arandr'          'hotplug_monitor' 'ssh-add'             'ezame')


# Check if the quantity matches
if [[ ${#Options[@]} -ne ${#Executables[@]} ]]; then
  echo "Options and Executables quantity don't match."
  exit 4
fi


# Variable passed to rofi
for i in "${Options[@]}"; do
  [[ -z $opt ]] && opt="$i" || opt="$opt\n$i"
done


# Call rofi
dir="$HOME/.config/rofi"
rofi_command="rofi -theme $dir/settingsmenu -me-select-entry MouseSecondary -me-accept-entry MousePrimary"
chosen="$(echo -e "$opt" | $rofi_command -p "  Configuration" -dmenu -selected-row 2)"


# Execute the chosen option
for i in ${!Options[@]}; do
  if [[ "${Options[$i]}" == "$chosen" ]]; then
    ${Executables[$i]}
    exit 0
  fi
done


# Fallback case chosen is not blank and not in Options
if [[ -n "$chosen" ]]; then
  echo "'$chosen' is not in known Options."
  exit 5
fi
