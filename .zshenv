export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
if which thefuck > /dev/null; then eval "$(thefuck --alias)"; fi
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
