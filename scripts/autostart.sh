#!/bin/bash
echo "autostart.sh"

# Fixme: this needs to check if programs aren't already open
#nohup spotify &
#nohup shutter --min_at_startup &

echo "looking for additional autostart files:"
for f in ~/scripts/*.autostart.sh; do
  [ -e "$f" ] || continue
  echo "found $f"
  sh $f
done
