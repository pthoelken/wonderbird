#!/bin/ash

set -e 

# Disable screensaver/powerdown inside the virtual display.
setterm blank 0 || true
setterm powerdown 0 || true
xset s off || true
xset -dpms || true

if [ -n "${WONDERBIRD_INITIAL_RESOLUTION:-}" ] && [ -z "${SELKIES_MANUAL_WIDTH:-}" ] && [ -z "${SELKIES_MANUAL_HEIGHT:-}" ]; then
    selkies-resize "$WONDERBIRD_INITIAL_RESOLUTION" || true
fi

keep-thunderbird-open &
exec dbus-launch --exit-with-session /usr/bin/i3 -c /defaults/i3config > /dev/null 2>&1
