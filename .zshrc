# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
if [ -d $HOME/.dotfiles/zsh ]; then
    ZSH_CUSTOM=$HOME/.dotfiles/zsh
    ZSH_THEME="isaac"
fi

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(osx vi-mode git python urltools lein brew bundler docker docker-compose arcanist fasd)

source $ZSH/oh-my-zsh.sh
autoload -U compinit promptinit
compinit
promptinit

#bindkey -v
bindkey '\e.' insert-last-word
bindkey '^y' insert-last-word
bindkey '\e/' vi-history-search-backward
bindkey '\em' copy-prev-shell-word
bindkey '\el' clear-screen
bindkey -a 'u' undo
bindkey -a '^R' redo
bindkey '^E' edit-command-line
bindkey -M vicmd 'v' visual-mode
#bindkey '^k' up-history
#bindkey '^j' down-history

# User configuration

alias vi='vim '
alias sudo='sudo '
alias xargs='xargs '
alias ssh='TERM=xterm ssh'

export EDITOR='vim'
# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Lines configured by zsh-newuser-install
#. ${HOME}/.dotfiles/.bashrc

alias urlencode='python -c "import sys, urllib as ul; print(ul.quote_plus(sys.argv[1]))" '
alias urldecode='python -c "import sys, urllib as ul; print(ul.unquote_plus(sys.argv[1]))"'

alias gck='git checkout'
alias sbcl='rlwrap sbcl '

if [[ `uname` == "Linux" ]]; then
    alias grep="/usr/bin/grep $GREP_OPTIONS"
    unset GREP_OPTIONS
#elif [[ `uname` == "Darwin" ]]; then
#    echo "this Darwin system"
fi

if [[ `uname` == 'Darwin' ]]; then
    export LANG="en_US.UTF-8"
fi

EMACS_NW=$HOME/.__emacs-nw
if [ ! -x $EMACS_NW ]; then
    cat <<EOF >> $EMACS_NW
#!/usr/bin/env bash
exec emacs -nw "\$@"
EOF
    chmod +x $EMACS_NW
fi
alias enw='emacs -nw'
alias e="TERM=xterm-256color emacsclient -a $EMACS_NW -t "
alias et='emacsclient -t '
# End of lines configured by zsh-newuser-install


export KEYTIMEOUT=1
setopt interactivecomments

upper() {
    echo $1 | tr '[:lower:]' '[:upper:]'
}

lower() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

export ANDROID_HOME=/usr/local/opt/android-sdk

PS1="$PS1"'$([ -n "$TMUX"  ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

if [[ -f ~/.private.env ]]; then
    source ~/.private.env
fi

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
export GOPATH=$HOME/go
GOBIN=${GOPATH:-$HOME/go}/bin
if [ -d $GOBIN ]; then
   export PATH=$PATH:$GOBIN
fi

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
:
