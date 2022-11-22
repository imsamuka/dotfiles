#!/usb/bin/sh

uptime=$(uptime -p | sed -e 's/up //')

echo '

^sep(  Settings)

LxAppearance (GTK),lxappearance,gtk3-demo
Kvantum (QT Theme),kvantummanager,kvantum
Qt Settings,qt5ct,QtIcon
Openbox Settings,obconf,obconf
Dconf Settings,dconf-editor,dconf-editor
Tint2 Settings,tint2conf,tint2conf
Display Settings,arandr,system-config-display
Applications Settings,ezame,ezame
Firewall Settings,gufw,gufw
Scripts,^checkout(scripts),menu-editor

^sep(  System)
Backup,st -t Backup -e tmux new-session -d "~/.scripts/particular/backup.sh; read" \; attach,grsync
Upgrade,st -t Upgrade -e tmux new-session -d "paru -Syyu; read" \; attach,start-here-archlinux
Exit,^checkout(exit),system-shutdown

^tag(scripts)
^sep(  Scripts)
Refresh,refresh,gtk-refresh
Toggle Compositor,toggle_compositor,compton
Toggle MPD,service_wrap mpd toggle mpd "Music Player Daemon" --user,mpd
Toggle Tor,service_wrap tor toggle tor,tor
Display Hotplug,^term(hotplug_monitor),preferences-desktop-display-symbolic
Wacom Hotplug,^term(hotplug_wacom),dcc_nav_wacom
Icon Browser,icon_browser.py,gtk3-icon-browser

^tag(exit)
"""^sep(   '"$uptime"')"""
Shutdown,systemctl poweroff,system-shutdown
Reboot,systemctl reboot,system-reboot
Hibernate,systemctl hybrid-sleep,system-hibernate
Logout,openbox --exit,system-log-out

'
