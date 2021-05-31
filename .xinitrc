
# Disable Blanking
xset s off
xset -dpms

# Enable Graphical Authentication Agent
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &

# Execute Openbox
exec openbox-session
