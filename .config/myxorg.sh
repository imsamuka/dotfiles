# This file is expected to run everytime Xorg Server starts
# Every Window Manager and Desktop Enviromment should run this at start
# Append this to your .xinitrc or window manager autostart:
# source $HOME/.config/myxorg.sh


# Disable Blanking
xset s off
xset -dpms

# Enable Numlock (to use numbers)
numlockx

# Enable Graphical Authentication Agent
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &

# Volctl - System Tray Volume Control
volctl &

# ClipIt - System Tray Clipboard Manager
clipit &

# Picom - Window Compositor
# picom -b

# Lead - Hot corners/sides
# lead &
