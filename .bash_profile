# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin
PATH=$PATH:"/opt/MyEclipse/MyEclipse 10"
PATH=$PATH:"$CLOJURESCRIPT_HOME/bin"

export PATH
