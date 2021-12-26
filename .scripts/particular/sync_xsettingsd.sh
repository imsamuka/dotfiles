#!/usr/bin/bash

gtk_variables=(
	"gtk-cursor-theme-name"
	"gtk-enable-event-sounds"
	"gtk-enable-input-feedback-sounds"
	"gtk-icon-theme-name"
	"gtk-sound-theme-name"
	"gtk-theme-name"
	"gtk-xft-antialias"
	"gtk-xft-dpi"
	"gtk-xft-hintstyle"
	"gtk-xft-hinting"
	"gtk-xft-rgba"
)

x_variables=(
	"Gtk/CursorThemeName"
	"Net/EnableEventSounds"
	"Net/EnableInputFeedbackSounds"
	"Net/IconThemeName"
	"Net/SoundThemeName"
	"Net/ThemeName"
	"Xft/Antialias"
	"Xft/DPI"
	"Xft/HintStyle"
	"Xft/Hinting"
	"Xft/RGBA"
)

for i in ${!gtk_variables[@]}; do

	gtk_var=${gtk_variables[$i]}
	new_value=$(sed -n "s/^ *$gtk_var *=\(.*\)/\1/p" ~/.gtkrc-2.0)

	x_var=${x_variables[$i]}
	x_var2=${x_var//'/'/'\/'}

	if [[ -n $new_value ]];
	then
		sed -i '/'".*$x_var2.*"'/,${s//'"$x_var2 $new_value"'/;b};$q5' ~/.xsettingsd \
		|| echo "$x_var $new_value" >> ~/.xsettingsd
	else
		sed -i "/.*$x_var2.*/d" ~/.xsettingsd
	fi

done

killall -HUP xsettingsd || xsettingsd &> /dev/null
