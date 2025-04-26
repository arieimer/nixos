#!/usr/bin/env bash

volume_notify() {
  volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')
  notify-send "Volume" "$volume"
}

sink_notify() {
  if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "MUTED"; then
    notify-send "Volume" "Muted"
  else
    volume_notify
  fi
}

source_notify() {
  if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q "MUTED"; then
    notify-send "Microphone" "Muted"
  else
    notify-send "Microphone" "Unmuted"
  fi
}


case $1 in
vol)
	case $2 in
	up)
		wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
		wpctl set-volume @DEFAULT_AUDIO_SINK@ "$3%+" --limit 1.0
		volume_notify
		exit 0
		;;
	down)
		wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
		wpctl set-volume @DEFAULT_AUDIO_SINK@ "$3%-"
		volume_notify
		exit 0
		;;
	toggle)
		wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
		sink_notify
		exit 0
		;;
	esac
	;;
mic)
	[ "$2" = "toggle" ] && wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && source_notify
	exit 0
	;;
*)
	echo "Invalid command: $1"
	exit 1
	;;
esac
