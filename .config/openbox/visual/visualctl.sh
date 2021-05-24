#!/usr/bin/env bash


# Initialize variables and functions
CUR_PATH=`dirname "$(readlink -f "$0")"`
CUR_FILE="$CUR_PATH/current"
CUR_MODE=`cat $CUR_FILE || echo dark`


print_log(){
  echo "[visualctl] $1"
}


change_config(){
  # USAGE: change_config Path Key Value
  sed -s -i "s/\($2 \?=\).*/\1 $3/" $1;
}


set_theme(){

  # Initialize Local Variables
  local GTK2_CONFIG="$HOME/.gtkrc-2.0"
  local GTK3_CONFIG="$HOME/.config/gtk-3.0/settings.ini"


  # Set Theme
  if  [[ -n $NEW_THEME ]] && \
      [[ -d "/usr/share/themes/$NEW_THEME" || \
         -d "$HOME/.local/share/themes/$NEW_THEME" || \
         -d "$HOME/.themes/$NEW_THEME" ]];
    then print_log "├─ Applying Theme '$NEW_THEME'.";

      change_config "$GTK2_CONFIG" "gtk-theme-name" "\"$NEW_THEME\""
      change_config "$GTK3_CONFIG" "gtk-theme-name" "$NEW_THEME"

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

    else print_log "├─ Icons '$NEW_ICONS' not found. No Changes.";
  fi


  # Set Cursor
  if  [[ -n $NEW_CURSOR ]] && \
      [[ -d "/usr/share/icons/$NEW_CURSOR/cursors" || \
         -d "$HOME/.local/share/icons/$NEW_CURSOR/cursors" || \
         -d "$HOME/.icons/$NEW_CURSOR/cursors" ]];
    then print_log "└─ Applying Cursor '$NEW_CURSOR'.";

      change_config "$GTK2_CONFIG" "gtk-cursor-theme-name" "\"$NEW_CURSOR\""
      change_config "$GTK3_CONFIG" "gtk-cursor-theme-name" "$NEW_CURSOR"

    else print_log "└─ Cursor '$NEW_CURSOR' not found. No Changes.";
  fi
}


set_panel(){

  # Restart
  if killall tint2 &> /dev/null;
    then print_log "└─ Restarting Tint2...";
    else print_log "└─ Starting Tint2...";
  fi
  tint2 &> /dev/null &
}


set_notification(){

  # Restart
  if killall dunst &> /dev/null;
    then print_log "└─ Restarting Dunst...";
    else print_log "└─ Starting Dunst...";
  fi
  dunst &> /dev/null &
}


set_visual() {

  # Initialize Local Variables
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
  notify-send -u low -i "#" "Changing Visual Mode" "${NEW_MODE^} Theme enabled" &> /dev/null &


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
