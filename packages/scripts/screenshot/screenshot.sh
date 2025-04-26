#!/usr/bin/env bash

fileName="Screenshot-$(date '+%m.%d.%y-%I:%M%P')"
screenshotDir="$XDG_PICTURES_DIR/Screenshots"
path="$screenshotDir/$fileName"

if [ ! -d "$screenshotDir" ]; then
  mkdir -p "$screenshotDir"
fi

case $1 in
--monitor)
  grim -g "$(slurp -or)" "$path"
  ;;
--selection)
  grim -g "$(slurp)" "$path"
  ;;
esac

if [ -f "$path" ]; then
  notify-send --icon="$path" "Screenshot saved and copied to clipboard $path"
  wl-copy <"$path"
  exit 0
fi

echo "Screenshot cancelled"
exit 1
