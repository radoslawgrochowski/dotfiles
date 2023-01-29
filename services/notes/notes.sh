#!/bin/sh

NOTES_DIR=$HOME/Projects/notes
if [ -d "$NOTES_DIR" ] 
then
  cd $NOTES_DIR
  if [[ -n $(git status -s) ]]; then
    echo "Changes found. Pushing changes..."
    git add -A && git commit -m "update"
    git push origin master
  else
    echo "No changes found. Skip pushing."
  fi
  git pull
else
  git clone https://github.com/radoslawgrochowski/notes.git $NOTES_DIR
fi
