#
# ~/.bash_profile
# Runs after login success
#

export PATH=$PATH:$HOME/.local/bin

[[ -f ~/.bashrc ]] && . ~/.bashrc

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx "/usr/bin/openbox-session"
fi

