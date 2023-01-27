#!/bin/sh

WALLPAPERS_DIR=$HOME/Pictures/Wallpapers
if [ -d "$WALLPAPERS_DIR" ] 
then
  cd $WALLPAPERS_DIR
  if [[ -n $(git status -s) ]]; then
    echo "Changes found. Pushing changes..."
    git add -A && git commit -m "update" && git push
  else
    echo "No changes found. Skip pushing."
  fi
  git pull
else
  git clone https://github.com/radoslawgrochowski/wallpapers.git $WALLPAPERS_DIR
fi
