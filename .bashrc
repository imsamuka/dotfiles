# This file is expected to run everytime a shell is instantiated
# This is made in case i switch shells


# Show Random Pokemon on colorful terminals
[ $(tput colors) = 256 ] && pokemon-colorscripts -r 1-3 | tail -n +2

### Sourcing

# oh-my-bash Scripts
export OSH=$HOME/.config/oh-my-bash
if [ -d "$OSH" ]; then

	if [ $(tput colors) = 256 ]; then
		OSH_THEME="powerline"
	else
		OSH_THEME="powerline-naked"
		POWERLINE_PROMPT_CHAR=">"
		POWERLINE_LEFT_SEPARATOR=">"
		POWERLINE_CHAR_SEPARATOR="|"
		POWERLINE_SCM_GIT_CHAR="@ "
	fi

	POWERLINE_PROMPT="scm cwd"
	DISABLE_UNTRACKED_FILES_DIRTY="true"

	# completions=()
	# aliases=()
	# plugins=()

	. $OSH/oh-my-bash.sh
else
	export PS1='\033[1;32m\w \033[1;90m>\033[0m '
	# export PS1='\w > '
fi


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
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias wget='wget -c'
alias grep='grep --color=auto'
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

