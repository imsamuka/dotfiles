#!/usr/bin/sh

mpc --wait volume "$1" || exit 1

volume=$(mpc volume | sed 's/volume: *//')

dunstify \
	-h int:value:"${volume%'%'}" \
	-t 1000 -r 66 \
	-i enjoy-music-player \
	-a "Music Player Daemon" \
	"MPD Volume"

