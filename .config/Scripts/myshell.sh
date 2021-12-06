# This file is expected to run everytime a shell is instantiated
# This is made in case i switch shells
# Append this to your .bashrc:
# source $HOME/.config/myshell.sh


# Theming
[[ $OSH_THEME == "brunton" ]] && prompt() {
  PS1="${white}${background_blue} \w ${blue}${reset_color}${normal}$(is_vim_shell) "
}



### Sourcing

# Functions
source $HOME/.config/Scripts/functions.sh

# asdf - Unified Version Management
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash



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
alias tor-update='sudo killall -HUP tor'

