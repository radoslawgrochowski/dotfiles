#!/bin/sh

pkill swaybg 
ls ~/Pictures/Wallpapers/ | sort -R | head -n1 | xargs -I {} swaybg -i "/home/radoslawgrochowski/Pictures/Wallpapers/{}" &
