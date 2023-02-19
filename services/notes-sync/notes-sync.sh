#!/bin/sh

NOTES_DIR=$HOME/Projects/notes
if [ -d "$NOTES_DIR" ] 
then
  cd $NOTES_DIR
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
  git clone https://github.com/radoslawgrochowski/notes.git $NOTES_DIR
fi
