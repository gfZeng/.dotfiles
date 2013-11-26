# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=5000
#bindkey -e
#bindkey -v
bindkey -v '\e.' insert-last-word
. /home/isaac/.dotfiles/.zsh_completion
. /home/isaac/.dotfiles/.bashrc
#export JAVA_HOME=/opt/jdk1.7.0_40

export PATH=$PATH:${HOME}/bin:/opt/node-v0.10.19-linux-x64/bin
export PATH=$PATH:/opt/hadoop-1.2.1/bin
export PATH=$PATH:/opt/local/mongodb/bin
JYTHONPATH=$JYTHONPATH:/usr/lib/python2.7/site-packages
alias jython='jython -Dpython.path=$JYTHONPATH '
#:${JAVA_HOME}/bin
# End of lines configured by zsh-newuser-install
