#!/bin/sh

REPO_DIR=$HOME/Pictures/Wallpapers
if [ -d "$REPO_DIR" ] 
then
  cd $REPO_DIR
  if [[ -n $(git status -s) ]]; then
    echo "Changes found. Commiting..."
    git add -A && git commit -m "update"
  fi
  if  [[ -n $(git log @{push}..) ]]; then
    echo "Pushing changes..."
    git push origin master
  fi
  git pull
else
  git clone https://github.com/radoslawgrochowski/wallpapers.git $REPO_DIR
fi
