#!/usb/bin/sh

uptime=$(uptime -p | sed -e 's/up //')

echo '

LxAppearance (GTK),lxappearance,gtk3-demo
Qt5 Settings,qt5ct,QtIcon
Openbox Theme,obconf,obconf
Tint2 Settings,tint2conf,tint2conf
Display Settings,arandr,system-config-display
Applications Settings,ezame,ezame
Firewall Settings,gufw,gufw

^sep(  Scripts)

Refresh,refresh,gtk-refresh
Display Hotplug,hotplug_monitor,preferences-desktop-display-symbolic
Wacom Hotplug,wacom-config.sh,dcc_nav_wacom
Icon Browser,icon-browser,gtk3-icon-browser

^sep(  System)

Exit,^checkout(exit),system-devices-information

^tag(exit)
"""^sep(   '$uptime')"""
Shutdown,systemctl poweroff,system-shutdown
Reboot,systemctl reboot,system-reboot
Hibernate,systemctl hybrid-sleep,system-hibernate
Logout,openbox --exit,system-log-out

'