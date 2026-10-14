#!/bin/sh
STATE_DIR="${XDG_RUNTIME_DIR:-${HOME}/.cache/corvos/run}"
mkdir -p "$STATE_DIR"
REVIEW_STATE="$STATE_DIR/dunst-history-review"
SOUND_FILE="${XDG_DATA_HOME:-${HOME}/.local/share}/corvos/sounds/pda-news.ogg"

if [ -e "$REVIEW_STATE" ]; then
    exit 0
fi

/usr/bin/ffplay -nodisp -autoexit -loglevel quiet -volume 50 \
    "$SOUND_FILE" >/dev/null 2>&1 &
