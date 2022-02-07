#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar
for monitor in $(xrandr --query | grep " connected" | cut -d" " -f1); do
  polybar -config=$HOME/.config/polybar/config.ini --reload $monitor &
done

echo "Bar launched..."
