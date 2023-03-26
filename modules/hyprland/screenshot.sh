#!/bin/sh

path=$HOME/Pictures/$(date +'%s_grim.png')
grim -g "$(slurp)" $path
wl-copy < $path
