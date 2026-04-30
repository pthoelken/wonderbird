#!/bin/sh
set -eu

while true; do
    if ! pidof thunderbird >/dev/null 2>&1 && ! pidof thunderbird-bin >/dev/null 2>&1; then
        thunderbird &
    fi

    sleep 2
done
