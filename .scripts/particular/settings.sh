#!/usb/bin/sh

uptime=$(uptime -p | sed -e 's/up //')

echo '

^sep(  Settings)

LxAppearance (GTK),lxappearance,gtk3-demo
Kvantum (QT Theme),kvantummanager,kvantum
Qt Settings,qt5ct,QtIcon
Openbox Settings,obconf,obconf
Tint2 Settings,tint2conf,tint2conf
Display Settings,arandr,system-config-display
Applications Settings,ezame,ezame
Firewall Settings,gufw,gufw

^sep(  Scripts)

Refresh,refresh,gtk-refresh
Toggle Compositor,toggle_compositor,compton
Backup,st -t Backup -e tmux new-session -d "~/.scripts/particular/backup.sh" \; attach,grsync
Display Hotplug,^term(hotplug_monitor),preferences-desktop-display-symbolic
Wacom Hotplug,^term(hotplug_wacom),dcc_nav_wacom
Icon Browser,icon_browser,gtk3-icon-browser

^sep(  System)

Upgrade,st -t Upgrade -e tmux new-session -d "paru -Syu" \; attach,start-here-archlinux
Exit,^checkout(exit),system-shutdown

^tag(exit)
"""^sep(   '$uptime')"""
Shutdown,systemctl poweroff,system-shutdown
Reboot,systemctl reboot,system-reboot
Hibernate,systemctl hybrid-sleep,system-hibernate
Logout,openbox --exit,system-log-out

'
