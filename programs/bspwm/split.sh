#!/bin/sh
NAMES=(1 2 3 "Music" "Comms" 6 7 8 9 10)
MONITORS=($(bspc query -M --names))
EVEN_COUNT=$((${#NAMES[@]} / ${#MONITORS[@]}))
REMINDER=$((${#NAMES[@]} - $(($EVEN_COUNT * ${#MONITORS[@]}))))

for index in "${!MONITORS[@]}"; do 
  START=$(($EVEN_COUNT * $index))
  MIDX=$((index + 1))
  if [[ $(($index + 1)) -eq ${#MONITORS[@]} ]]; then
    COUNT=$(($EVEN_COUNT + $REMINDER))
  else
    COUNT=$EVEN_COUNT
  fi
  bspc monitor ^$MIDX -d ${NAMES[@]:$START:$COUNT}
done


