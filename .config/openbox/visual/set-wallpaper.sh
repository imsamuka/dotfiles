# Get the first argument given OR "dark" by default
[[ -z "$1" ]] && FN="dark" || FN="$1"

# Find all wallpapers starting with that word, an put them in order as backgrounds
feh --bg-fill --no-fehbg $(find -L ~/Images/Wallpapers -name "$FN*" -printf '%p ')