# oh-my-zsh configuration
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="lambda"
DISABLE_AUTO_UPDATE="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# user configuration

# language environment
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# preferred editor
export EDITOR="vim"

# alias
alias ll="ls -lah"

# homebrew
export HOMEBREW_NO_AUTO_UPDATE=1

# coreutils
PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH

test -e ~/.dircolors && eval `dircolors -b ~/.dircolors`

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
