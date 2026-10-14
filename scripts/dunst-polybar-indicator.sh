#!/bin/sh

MUTE_STATE=/tmp/dunst-polybar-muted
REVIEW_STATE=/tmp/dunst-history-review

update_indicator() {
    if [ -e "$MUTE_STATE" ]; then
        hook=2
    elif [ "$(dunstctl count history 2>/dev/null)" -gt 0 ]; then
        hook=1
    else
        hook=0
    fi

    /usr/bin/polybar-msg action "#notifications.hook.$hook" >/dev/null 2>&1 || true
}

case "$1" in
    mute-toggle)
        if [ -e "$MUTE_STATE" ]; then
            dunstctl rule polybar-mute disable || exit 1
            rm -f "$MUTE_STATE"
        else
            dunstctl rule polybar-mute enable || exit 1
            touch "$MUTE_STATE"
            dunstctl close-all >/dev/null 2>&1 || true
        fi
        update_indicator
        ;;

    startup)
        rm -f "$MUTE_STATE"
        dunstctl rule polybar-mute disable || exit 1
        update_indicator
        ;;

    review)
        was_muted=0

        if [ -e "$MUTE_STATE" ]; then
            dunstctl rule polybar-mute disable || exit 1
            was_muted=1
        fi

        touch "$REVIEW_STATE"

        review_cleanup() {
            rm -f "$REVIEW_STATE"
            if [ "$was_muted" -eq 1 ]; then
                dunstctl rule polybar-mute enable >/dev/null 2>&1 || true
            fi
            update_indicator
        }

        trap review_cleanup EXIT
        trap 'exit 130' INT
        trap 'exit 143' TERM

        while [ "$(dunstctl count history)" -gt 0 ]; do
            dunstctl history-pop >/dev/null 2>&1 || break
        done

        while [ "$(( $(dunstctl count displayed) + $(dunstctl count waiting) ))" -gt 0 ]; do
            sleep 0.25
        done

        dunstctl history-clear
        ;;

    clear)
        dunstctl history-clear
        update_indicator
        ;;

    *)
        timeout="${DUNST_TIMEOUT:-0}"
        case "$timeout" in
            ''|*[!0-9]*) timeout=0 ;;
        esac

        [ "$timeout" -le 0 ] && exit 0

        sleep "$((timeout / 1000)).$((timeout % 1000))"
        update_indicator
        ;;
esac
