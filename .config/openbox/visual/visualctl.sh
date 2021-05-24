#!/usr/bin/env bash


# Initialize variables and functions
CUR_PATH=`dirname "$(readlink -f "$0")"`
CUR_FILE="$CUR_PATH/current"
CUR_MODE=`cat $CUR_FILE || echo dark`


print_log(){
  echo "[visualctl] $1"
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


  # Set Theme & UI
  # print_log "Setting GTK theme: TODO"
  #( "$VISMOD_DIR/mechanical/theme" ) &> /dev/null


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
