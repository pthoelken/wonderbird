#!/bin/bash
set -e

mkdir -p /config/.config/i3
cp /defaults/i3config /config/.config/i3/config

exec /init
