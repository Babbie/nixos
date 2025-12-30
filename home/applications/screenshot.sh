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
    wayfreeze --hide-cursor --after-freeze-cmd "grim -g '$X,$Y ${W}x$H' - | tee '$FILE' | wl-copy && notify-send -a 'Screenshot' 'Active window screenshot copied to clipboard' 'File saved to $FILE'; pkill -f wayfreeze";;
  *)
    wayfreeze --hide-cursor --after-freeze-cmd "grim -g "'"$(slurp)"'" - | tee '$FILE' | wl-copy && notify-send -a 'Screenshot' 'Screenshot copied to clipboard' 'File saved to $FILE'; pkill -f wayfreeze";;
esac
