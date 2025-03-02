# Oh-My-Zsh Configuration
export ZSH=$HOME/.oh-my-zsh
export XDG_CONFIG_HOME=$HOME/.config
ZSH_THEME="lambda"
DISABLE_AUTO_UPDATE="true"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Language Environment
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Editor Configuration
export EDITOR="nvim"

# Path Configuration
# Coreutils
COREUTILS_BIN="/usr/local/opt/coreutils/libexec/gnubin"
COREUTILS_MAN="/usr/local/opt/coreutils/libexec/gnuman"
export PATH="$COREUTILS_BIN:$PATH"
export MANPATH="$COREUTILS_MAN:$MANPATH"

# Tmuxifier
TMUXIFIER_BIN="$HOME/.config/tmux/plugins/tmuxifier/bin"
export PATH="$TMUXIFIER_BIN:$PATH"
eval "$(tmuxifier init -)"

# Aliases
alias vim="nvim"
alias ll="ls -lGH --color=tty"
alias lla="ls -lGaH --color=tty"
alias mkdir="mkdir -p"
alias tree="tree -laI 'node_modules|.git' --dirsfirst" 

# Quick Notes Access
alias notes="vim $HOME/notes.md"
alias work="vim $HOME/work.md"
alias tasks="vim $HOME/tasks.md"
alias admin="vim $HOME/administrative.md"

# Homebrew Configuration
export HOMEBREW_NO_AUTO_UPDATE=1

# Dircolors (if available)
if [ -e "$HOME/.dircolors" ]; then
    eval "$(dircolors -b $HOME/.dircolors)"
fi
