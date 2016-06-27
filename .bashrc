# .bashrc

# User specific aliases and functions

alias rm='rm -I'
alias cp='cp -i'
alias mv='mv -i'
alias sudo='sudo '

# Source global definitions
if [ -f /etc/bashrc -a "$0" = "/bin/bash" ]; then
	. /etc/bashrc
fi

# add by myself
alias vi='vim'

# colorful prompt
#PS1='${fedora_chroot:+($fedora_chroot)}\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[01;34m\] \W\[\033[00m\]\$ '
#PS1='${fedora_chroot:+($fedora_chroot)}\[\033[01;33m\]\t\[\033[00m\]:\[\033[01;34m\] \W\[\033[00m\]\$ '
# root bashrc file {
#PS1='${fedora_chroot:+($fedora_chroot)}\[\033[01;31m\]\t\[\033[00m\]:\[\033[01;34m\] \w\[\033[00m\]\$ '
# }

# colorful command (ls, grep)
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ls='ls --color=auto '
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# alias ping
alias ping='ping -c 3 '

# alias xdg-open
alias xdg-open='xdg-open &>/dev/null '

# alias for gcc {
alias cc='gcc -Wall -std=c99 -I$HOME/projects/c/include -L$HOME/projects/c/lib64 '
alias c++='g++ -Wall -I$HOME/projects/cpp/include -I$HOME/projects/c/include -L$HOME/projects/cpp/lib64 -L$HOME/projects/c/lib64'
#function cc {
#    gcc -Wall -std=c99 -I$HOME/projects/c/include -L$HOME/projects/c/lib64 "$@"
#}
# }
export CLOJURESCRIPT_HOME=/home/rose/clojurescript
alias xclip='xclip -sel clipboard'
alias emacs='LC_CTYPE=zh_CN.UTF-8 emacs '
alias urlencode='python2 -c "import sys, urllib as ul; print(ul.quote_plus(sys.argv[1]))" '
alias urldecode='python2 -c "import sys, urllib as ul; print(ul.unquote_plus(sys.argv[1]))"'

export PATH=${PATH}:/opt/local/android-studio/sdk/platform-tools:/opt/local/android-studio/sdk/build-tools/android-4.4.2:/opt/local/android-studio/sdk/tools
export PATH=${PATH}:/opt/local/otp/bin
