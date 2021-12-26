# This file is expected to run everytime a shell is instantiated
# This is made in case i switch shells



### Sourcing

# Functions
. "$HOME/.scripts/particular/functions.sh"
mpd_yt () { youtube-dl -f bestaudio -g "$@" | mpc add; }
git_forked () {
	git remote -v # Show current
	git remote -v remove origin
	local nm="${1:-$(basename "$(pwd)")}"
	git remote -v add -f origin git@github.com:imsamuka/"$nm".git
}

# asdf - Unified Version Management
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

# Tab completion
complete -c man which tldr cheat bro
complete -cf sudo doas entr


### Aliases

# Dotfiles Management
alias dots='git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME'

# Adding default options
alias paru='paru --skipreview'
alias less='less --chop-long-lines --use-color --mouse --wheel-lines=4'

# Replacements
alias ls="exa --no-time --header --icons --color=always --sort=name --group-directories-first"
alias code='codium'

# Simple Functions
alias freecheck='free -thc 999999 -s 0.3 --si'
alias dl-music='youtube-dl -o '"'%(title)s.%(ext)s'"' --extract-audio --audio-format mp3 --embed-thumbnail --add-metadata --audio-quality 0'
alias dl-podcast='youtube-dl -o '"'%(title)s.%(ext)s'"' --extract-audio --audio-format mp3 --embed-thumbnail --add-metadata'
alias play-music='mpv --no-video'
alias play-video='mpv'
alias tor-update='doas killall -HUP tor'

