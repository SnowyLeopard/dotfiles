# Set up the prompt

# autoload -Uz promptinit
# promptinit
# prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

export PATH="/home/snowy/.local/bin:/home/snowy/.rvm/gems/ruby-2.3.0/bin:/home/snowy/.linuxbrew/bin:$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export POWERLINE_COMMAND="$HOME/.local/bin/powerline"
export POWERLINE_CONFIG_COMMAND="$HOME/.local/bin/powerline-config"
source $HOME/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
$HOME/.local/bin/powerline-daemon -q

export TERM="xterm-256color"
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
#source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
# source /var/lib/gems/2.1.0/gems/tmuxinator-0.6.11/completion/tmuxinator.zsh
# source /home/snowy/.rvm/gems/ruby-2.3.0/gems/tmuxinator-0.8.1/completion/tmuxinator.zsh

PYTHONDONTWRITEBYTECODE=false
export PYTHONDONTWRITEBYTECODE
alias mux="tmuxinator"

export EDITOR=vim
export SHELL=/bin/zsh
export TERM=xterm-256color
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
