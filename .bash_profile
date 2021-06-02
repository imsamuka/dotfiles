#
# ~/.bash_profile
#

export PATH=$PATH:$HOME/.local/bin

[[ -f ~/.bashrc ]] && . ~/.bashrc


if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx "/usr/bin/openbox-session"
fi

