#!/bin/sh
dunst &
emacs --daemon
lxpolkit &
nitrogen --restore &
pcmanfm -d &
picom &
xfce4-power-manager &