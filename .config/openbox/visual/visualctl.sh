#!/usr/bin/env bash


# Initialize variables and functions
CUR_PATH=`dirname "$(readlink -f "$0")"`
CUR_FILE="$CUR_PATH/current"
CUR_MODE=`cat $CUR_FILE || echo dark`


print_log(){
  echo "[visualctl] $1"
}


change_config(){

  # USAGE: change_config [-q | --quotes] Path Key Value
  # Will return 5 if not found any match

  if [[ $# -lt 3 ]]
    then
      echo "[change_config] Must have 3 or more arguments"
      return 1
  fi

  if  [[ "$1" == '-q' || "$1" == '--quotes' ]];
    then
      shift # To remove the flag

      # Matching
      # 1: Is the start of a line or a non-word character (A-z1-9_)
      # 2: The 'key' argument plus a '=' character
      # 3: A " or a '
      # #: Every character until the last same " or ' found
      local pattern="\(\W\|^\)\($2=\)\(\"\|'\).*\3"
      local replacement="\1\2\3$3\3"
    else

      # Matching
      # 1: Is the start of a line with 0 or more spaces
      # 2: The 'key' argument, 0 or more spaces,  '=' character
      # #: Every character until the end of line
      local pattern="^ *\($2 *=\).*"
      local replacement="\1$3"
  fi

  # Run this to see WHAT and IF the replacement is working
  # sed -s '/'"${pattern}"'/,${s//\x1b[32m&\x1b[0m/;b};$q5' $1

  sed -i -s '/'"${pattern}"'/,${s//'"${replacement}"'/;b};$q5' $1
}


set_theme(){

  # Initialize Local Variables
  local GTK2_CONFIG="$HOME/.gtkrc-2.0"
  local GTK3_CONFIG="$HOME/.config/gtk-3.0/settings.ini"
  local XSETTINGSD_CONFIG="$HOME/.xsettingsd"


  # Set Theme
  if  [[ -n $NEW_THEME ]] && \
      [[ -d "/usr/share/themes/$NEW_THEME" || \
         -d "$HOME/.local/share/themes/$NEW_THEME" || \
         -d "$HOME/.themes/$NEW_THEME" ]];
    then print_log "├─ Applying Theme '$NEW_THEME'.";

      change_config "$GTK2_CONFIG" "gtk-theme-name" "\"$NEW_THEME\""
      change_config "$GTK3_CONFIG" "gtk-theme-name" "$NEW_THEME"
      sed -i '2s_Net/ThemeName.*_Net/ThemeName "'"$NEW_THEME"'"_' $XSETTINGSD_CONFIG

    else print_log "├─ Theme '$NEW_THEME' not found. No Changes.";
  fi


  # Set Icons
  if  [[ -n $NEW_ICONS ]] && \
      [[ -d "/usr/share/icons/$NEW_ICONS" || \
         -d "$HOME/.local/share/icons/$NEW_ICONS" || \
         -d "$HOME/.icons/$NEW_ICONS" ]];
    then print_log "├─ Applying Icons '$NEW_ICONS'.";

      change_config "$GTK2_CONFIG" "gtk-icon-theme-name" "\"$NEW_ICONS\""
      change_config "$GTK3_CONFIG" "gtk-icon-theme-name" "$NEW_ICONS"
      sed -i '1s_Net/IconThemeName.*_Net/IconThemeName "'"$NEW_ICONS"'"_' $XSETTINGSD_CONFIG

    else print_log "├─ Icons '$NEW_ICONS' not found. No Changes.";
  fi


  # Restart Xsettingsd
  if killall xsettingsd &> /dev/null;
    then print_log "└─ Restarting Xsettingsd...";
    else print_log "└─ Starting Xsettingsd...";
  fi
  xsettingsd &> /dev/null &
}


set_panel(){

  # Kill Tint2
  if killall tint2 &> /dev/null;
    then print_log "├─ Restarting Tint2...";
    else print_log "├─ Starting Tint2...";
  fi

  # Open Tint2
  if [[ -f "$HOME/.config/tint2/$NEW_MODE.tint2rc" ]]
    then print_log "└─ Opening Tint2 with '$NEW_MODE.tint2rc'."
         tint2 -c "$HOME/.config/tint2/$NEW_MODE.tint2rc" &> /dev/null &
    else print_log "└─ Opening Tint2 with defaults."
         tint2 &> /dev/null &
  fi
}


set_notification(){

  # Kill Dunst
  if killall dunst &> /dev/null;
    then print_log "├─ Restarting Dunst...";
    else print_log "├─ Starting Dunst...";
  fi

  # Open Dunst
  if [[ -f "$HOME/.config/dunst/$NEW_MODE.dunstrc" ]]
    then print_log "└─ Opening Dunst with '$NEW_MODE.dunstrc'."
         dunst -conf "$HOME/.config/dunst/$NEW_MODE.dunstrc" &> /dev/null &
    else print_log "└─ Opening Dunst with defaults."
         dunst &> /dev/null &
  fi
}


set_visual() {

  # Initialize Variables
  NEW_MODE=${1:?"Must provide visual mode name"}
    test "$NEW_MODE" == "$CUR_MODE"
  RESTARTING=$?
  test -f "$CUR_PATH/$NEW_MODE" && \
    source "$CUR_PATH/$NEW_MODE"


  # Logs
  if [ $RESTARTING == 0 ];
    then print_log "Restarting visuals from '$CUR_MODE'";
    else print_log "Changing visuals from '$CUR_MODE' to '$NEW_MODE'";
  fi


  # Set Wallpaper
  print_log "Setting Wallpaper..."
  "$CUR_PATH/set-wallpaper.sh" "$NEW_MODE"


  # Set Panel
  print_log "Setting Panel..."
  set_panel


  # Set Notification Daemon
  print_log "Setting Notification..."
  set_notification


  # Set Theme
  print_log "Setting Theme..."
  set_theme


  # Reconfigure Openbox
  print_log "Setting Window Manager..."
  print_log "└─ Reconfiguring Openbox..."
  openbox --reconfigure


  # Notify Results to User
  print_log "Notifying user..."
  notify-send -u low -i "$HOME/.icons/gladient/themer.png" "${NEW_MODE^} Theme enabled" "" &> /dev/null &


  # Store the new visual value
  print_log "Saving the chosen visual..."
  echo "$NEW_MODE" >| "$CUR_FILE"


  # Exit
  print_log "Visuals set successfully."
  exit 0
}


# Search for a Xorg Display
test -z $DISPLAY && print_log "Couldn't find a Display." && exit 1


# Select the use case
case $1 in

    # Toggle between configured options
    test) set -x ;&
    toggle|"")
      [[ $CUR_MODE != *"dark"* ]] && set_visual dark
      [[ $CUR_MODE != *"light"* ]] && set_visual light
    ;;

    # Option to Initialize it
    start|restart|refresh) set_visual "$CUR_MODE" ;;

    # Choose any visual
    *) set_visual "$1" ;;
esac
