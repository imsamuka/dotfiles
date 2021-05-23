#!/usr/bin/env bash
#set -x



# Initialize variables and functions
CUR_PATH=`dirname "$(readlink -f "$0")"`
CUR_FILE="$CUR_PATH/current"
CUR_MODE=`cat $CUR_FILE || echo dark`

set_panel(){


  # Restart
  if killall tint2 &> /dev/null;
    then echo "[visualctl] └─ Restarting Tint2...";
    else echo "[visualctl] └─ Starting Tint2...";
  fi
  tint2 &> /dev/null &
}

set_notification(){


  # Restart
  if killall dunst &> /dev/null;
    then echo "[visualctl] └─ Restarting Dunst...";
    else echo "[visualctl] └─ Starting Dunst...";
  fi
  dunst &> /dev/null &
}

set_visual() {


  # Make sure a visual mode name was given
  if [[ -z "$1" ]]; then
    echo "[visualctl] Must provide visual mode name" 1>&2
    exit 1
  fi


  # Initialize Local Variables
  NEW_MODE="$1"
    test "$NEW_MODE" == "$CUR_MODE"
  RESTARTING=$?


  # Logs
  if [ $RESTARTING == 0 ];
    then echo "[visualctl] Restarting visuals from '$CUR_MODE'";
    else echo "[visualctl] Changing visuals from '$CUR_MODE' to '$NEW_MODE'";
  fi


  # Set Wallpaper
  echo "[visualctl] Setting Wallpaper..."
  "$CUR_PATH/set-wallpaper.sh" "$NEW_MODE"


  # Set Panel
  echo "[visualctl] Setting Panel..."
  set_panel


  # Set Notification Daemon
  echo "[visualctl] Setting Notification..."
  set_notification


  # Set Theme & UI
  echo "[visualctl] Setting GTK theme: TODO"
  #( "$VISMOD_DIR/mechanical/theme" ) &> /dev/null


  # Notify Results to User
  echo "[visualctl] Notifying user..."
  notify-send -u low -i "#" "Changing Visual Mode" "${NEW_MODE^} Theme enabled"


  # Store the new visual value
  echo "[visualctl] Saving the chosen visual..."
  echo "$NEW_MODE" >| "$CUR_FILE"


  # Exit
  echo "[visualctl] Visuals set successfully."
  exit 0
}



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
