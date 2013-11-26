#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

setxkbmap -option caps:swapescape
#export GTK_IM_MODULE=ibus
#export QT_IM_MODULE=ibus
#export XMODIFIERS="@im=ibus"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

# exec startkde
exec startxfce4
#exec gnome-session
#gnome-session
#$HOME/.resolution
# ...or the Window Manager of your choice
#if [ -f ~/.Xmodmap ]; then
#    xmodmap ~/.Xmodmap
#fi
