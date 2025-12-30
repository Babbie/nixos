#!/usr/bin/env bash
mkdir -p /tmp/screenshots
FILE=/tmp/screenshots/$(date +\%Y\-\%m\-\%d_\%H\-\%M\-\%S).png 
case $1 in
  active)
    {
      read _ _ X
      read _ _ Y
      read _ _ W
      read _ _ H
    } < <(mmsg -x)
    grim -g "$X,$Y ${W}x$H" - | tee "$FILE" | wl-copy && notify-send -a "Screenshot" "Active window screenshot copied to clipboard" "File saved to $FILE";;
  *)
    grim -g "$(slurp)" - | tee "$FILE" | wl-copy && notify-send -a "Screenshot" "Screenshot copied to clipboard" "File saved to $FILE";;
esac
