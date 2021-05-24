
# Disable Blanking
xset s off
xset -dpms

# Temporary Solution to Internet Connection
(
iwctl station wlan0 scan
sleep 5
iwctl station wlan0 connect "BMT 08"
) &

# Enable Graphical Authentication Agent
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &

# Execute Openbox
exec openbox-session
