# This file is expected to run everytime Xorg Server starts
# Every Window Manager and Desktop Enviromment should run this at start
# Append this to your .xinitrc or window manager autostart:
# source $HOME/.config/myxorg.sh

# Screen Layout
# xrandr --output VGA1 --mode 1440x900 --rate 59.89 --right-of LVDS1 --output LVDS1 --mode 1366x768 --rate 60.00

# Disable Blanking
xset s off
xset -dpms

# Enable Numlock (to use numbers)
numlockx

# Enable Graphical Authentication Agent
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &

# Volctl - System Tray Volume Control
# volctl &
# Being started on tint2ctl

# ClipIt - System Tray Clipboard Manager
# clipit &
# Being started on tint2ctl

# Flameshot - PrintScreen Manager
flameshot &

# Picom - Window Compositor
# picom -b

# Lead - Hot corners/sides
# lead &

# xsettingsd syncing with gtk2rc hack
sh -c 'echo ~/.gtkrc-2.0 | entr -np ~/.scripts/sync_xsettingsd.sh & disown' &

##### User Programs #####

if [[ -d /media/ArquivosGerais/Samuka ]]; then
  qbittorrent &
  #quiterss &
fi


