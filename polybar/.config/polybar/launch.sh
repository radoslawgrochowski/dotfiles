#!/bin/bash

# Terminate already running bar instances
killall -q polybar

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload example 2>&1 | tee -a /tmp/polybar.log & disown
  done
else
  polybar --reload example &
fi

echo "Polybar launched..."
