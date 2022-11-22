# This file is expected to run everytime Xorg Server starts
# Every Window Manager and Desktop Enviromment should run this at start

# Screen Layout
xrandr --output HDMI1 --off --output LVDS1 --auto --output VGA1 --auto --primary --right-of LVDS1

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

# Gnome Keyring
. /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# Clipboard Manager
clipmenud &

# ScreenShot Manager
flameshot &

# Window Compositor
toggle_compositor on &

# Hot corners/sides
# lead &

# Hotkey Daemon
sxhkd &

# Xresources
xrdb ~/.Xresources

# xsettingsd syncing with gtk2rc hack
# sh -c 'echo ~/.gtkrc-2.0 | entr -np ~/.scripts/particular/sync_xsettingsd.sh & disown' &
xsettingsd &

##### User Programs #####


