#!/bin/bash
echo "autostart.sh"

nohup spotify &
nohup shutter --min_at_startup &

echo "looking for additional autostart files:"
for f in ~/scripts/*.autostart.sh; do
  [ -e "$f" ] || continue
  echo "found $f"
  sh $f
done
