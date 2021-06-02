# This file is expected to run everytime a shell is instantiated
# This is made in case i switch shells
# Append this to your .bashrc:
# source $HOME/.config/myshell.sh


### Sourcing

# Functions
source $HOME/Scripts/functions.sh

# asdf - Unified Version Management
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash



### Aliases

# Dotfiles Management
alias dots='git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME'

# Adding default options
alias paru='paru --skipreview'

# Others
alias ls="exa --no-time --header --icons --color=always --sort=name --group-directories-first"
alias code='codium'

