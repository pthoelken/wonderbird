#!/bin/sh
set -eu

export GTK_CSD="${GTK_CSD:-0}"
export MOZ_GTK_TITLEBAR_DECORATION="${MOZ_GTK_TITLEBAR_DECORATION:-system}"

while true; do
    if ! pidof thunderbird >/dev/null 2>&1 && ! pidof thunderbird-bin >/dev/null 2>&1; then
        thunderbird &
    fi

    sleep 1
done
