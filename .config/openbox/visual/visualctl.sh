#!/usr/bin/env bash
#set -x



# Initialize variables and functions
CUR_PATH=`dirname "$(readlink -f "$0")"`
CUR_FILE="$CUR_PATH/current"
CUR_MODE=`cat $CUR_FILE || echo dark`


set_visual() {


  # Make sure a visual mode name was given
  if [[ -z "$1" ]]; then
    echo "[visualctl] Must provide visual mode name" 1>&2
    exit 1
  fi


  # Logs
  [[ "$CUR_MODE" == "$1" ]] \
    && echo "[visualctl] Restarting visuals from '$CUR_MODE'" \
    || echo "[visualctl] Changing visuals from '$CUR_MODE' to '$1'"


  # Store the new visual value
  echo "[visualctl] Saving the chosen visual..."
  echo "$1" >| "$CUR_FILE"


  # Set Wallpaper
  echo "[visualctl] Setting Wallpaper..."
  "$CUR_PATH/set-wallpaper.sh" "$1"


  # Set Theme & UI
  echo "[visualctl] Setting GTK theme: TODO"
  #( "$VISMOD_DIR/mechanical/theme" && "$VISMOD_DIR/UI" ) &> /dev/null


  # Notify Results to User
  echo "[visualctl] Notifying user: TODO"
  #notify-send -u low -i "$NOTIF_EYC_MIN_ICON" "Minimal Mode" "Eyecandy Theme enabled"


  # Exit
  echo "[visualctl] Visuals set successfully."
  exit 0
}



case $1 in

    # Toggle between configured options
    toggle|"")
      [[ $CUR_MODE != *"dark"* ]] && set_visual dark
      [[ $CUR_MODE != *"light"* ]] && set_visual light
    ;;

    # Option to Initialize it
    start|restart|refresh) set_visual "$CUR_MODE" ;;

    # Choose any visual
    *) set_visual "$1" ;;
esac
