# This file is expected to run everytime Xorg Server starts
# Every Window Manager and Desktop Enviromment should run this at start
# Append this to your .xinitrc or window manager autostart:
# source $HOME/.config/myxorg.sh

# Screen Layout
# xrandr --output VGA1 --mode 1440x900 --rate 59.89 --right-of LVDS1 --output LVDS1 --mode 1366x768 --rate 60.00

# Remap CapsLock to Escape
# setxkbmap -option caps:escape

# Change Xorg typematic delay and rate
xset r rate 300 35

# Disable Blanking
xset s off
xset -dpms

# Enable Numlock (to use numbers)
numlockx

# Graphical Authentication Agent
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &

# Clipboard Manager
clipmenud &

# ScreenShot Manager
flameshot &

# Window Compositor
toggle_compositor on &

# Hot corners/sides
# lead &

# xsettingsd syncing with gtk2rc hack
sh -c 'echo ~/.gtkrc-2.0 | entr -np ~/.scripts/particular/sync_xsettingsd.sh & disown' &

##### User Programs #####

if [[ -d /media/ArquivosGerais/Samuka ]]; then
  qbittorrent &
  #quiterss &
fi


