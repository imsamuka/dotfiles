#!/usr/bin/env bash
set -x

CUR_PATH=`dirname "$(readlink -f $0)"`
CUR_FILE="$CUR_PATH/current"
CUR_MODE="$(cat $CUR_FILE)"


set_visual() {
  # Make sure a visual mode name was given
  if [[ -z "$1" ]]; then
    echo "Must provide visual mode name" 1>&2
    exit 1
  fi

  # Store the new visual value
  echo "$1" > "$CUR_FILE"
  
  # Set Wallpaper For this
  ~/Scripts/setWallpaper.sh "$1"

  # Set Theme & UI
  # ( "$VISMOD_DIR/mechanical/theme" && "$VISMOD_DIR/UI" ) &> /dev/null

  # Notify Success
  #  notify-send -u low -i "$NOTIF_EYC_MIN_ICON" "Minimal Mode" "Eyecandy Theme enabled"

  exit 0
}



case $1 in
    start) # Initialize it
      set_visual "$CUR_MODE"
    ;;
    toggle|"") # Toggle
      if [[ $CUR_MODE != *"dark"* ]]; then
          set_visual dark
      elif [[ $CUR_MODE != *"light"* ]]; then
          set_visual light # Change to light in the future
      fi
    ;;
    *) # Choose any visual
      set_visual "$1"
    ;;
esac
