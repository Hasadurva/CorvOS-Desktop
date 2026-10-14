#!/bin/sh

if [ -e /tmp/dunst-history-review ]; then
    exit 0
fi

/usr/bin/ffplay -nodisp -autoexit -loglevel quiet -volume 50 \
    "/home/kraut/Customization/PDA News.ogg" >/dev/null 2>&1 &
