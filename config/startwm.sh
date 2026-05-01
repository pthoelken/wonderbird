#!/bin/ash

set -e 

# Disable Screensaver and enable full power mode
setterm blank 0
setterm powerdown 0
xset s 0 0

thunderbird & 
/usr/bin/pulseaudio --start
/usr/bin/i3 > /dev/null 2>&1