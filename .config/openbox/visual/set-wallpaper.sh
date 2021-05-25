# Search for a Xorg Display
test -z $DISPLAY && echo "[set-wallpaper] Couldn't find a Display." && exit 1

# Get the first argument if given else use "dark" by default
QUERY=${1:-'dark'}



# Find all wallpapers starting with that argument
#   Supported Types: PNG JPEG GIF TIF (not by some limitation, add as please)
#   Sorted order:    DEPTH -> ALPHABETICAL Dirs -> ALPHABETICAL Files
#     /name1.jpg
#     /name3.jpg
#     /a/name5.jpg
#     /c/name4.jpg
#     /c/name6.jpg
#     /a/b/name2.jpg
#
#   I think this regex is TOO much, but i couldn't find better a alternative
echo "[set-wallpaper] Searching for '$QUERY'..."

RES=`\
find -L ~/Images/Wallpapers -type f -regextype posix-extended \
-regex "[^ ]*/$QUERY[A-z0-9_-]*\.(png|jpe?g|gif|tiff?|PNG|JPE?G|GIF|TIFF?)$" \
-printf '%d\0%h\0%p\n' | \
sort -t '\0' -n | \
awk -F '\0' '{print $3}'`



# Exit if found nothing
if [[ -z "$RES" ]]; then
  echo "[set-wallpaper] No files found starting with '$QUERY' in ~/Images/Wallpapers/**"
  exit 2
fi



# Logs
echo "[set-wallpaper] Found these images:"

[[ -x "$(command -v exa)" ]] \
  && echo "$RES" | xargs exa -al --no-time --icons --color=always \
  || echo "$RES" | xargs ls -Alf --color=always

echo "[set-wallpaper] Setting Wallpapers..."



# Put them in order as backgrounds - Each one will be in a monitor
feh --bg-fill --no-fehbg $RES
if [ $? == 0 ];
  then echo "[set-wallpaper] Wallpapers set successfully."
  else echo "[set-wallpaper] Failed setting wallpapers."
       exit 1
fi
