#!/usr/bin/env bash
dir=$(dirname "$0")

source "$dir"/bar_colors.sh

# Misc
BAR_FIFO=/tmp/bar-fifo

function init_fifo() {
    rm -r $BAR_FIFO
    mkfifo $BAR_FIFO
}

function init_daemons() {
    get_tag
    get_bat
    get_net
    get_date
    get_updates
    get_music
}

#TODO: Add notifications for mails, system updates, youtube notifs?, rss feeds,
# high cpu and ram usage, low disk space, new patches on suckless wiki, new
# versions for st / dwm / dmenu, new versions for go packages?
# a clickable area with TODOs! and random ideas
# Clicking on the battery thing displays either dmenu info or lemonbar's thing
# maybe even tint2 or other panel?
function get_date() {
    while true
    do
        date=$(date +"%A %d %B")
        time=$(date +"%R")
        calen="%{F$color06 R}  %{F- B$color00}"
        echo 'D' "$calen $date", "$time "

        sleep 59
    done > $BAR_FIFO &
}

function get_bat() {
    while true
    do
        bat_icon=
        status=$(< /sys/class/power_supply/BAT0/status)

        case $status in
            "Discharging")
                bat_icon=;;

            "Charging")
                bat_icon=;;

            *)
                bat_icon=;;
        esac

        bat="%{F$color03 R} $bat_icon %{F- B$color00}"

        echo 'B' "$bat $(< /sys/class/power_supply/BAT0/capacity)%"

        sleep 30
    done > $BAR_FIFO &
}

function get_net() {
    while true
    do
        name=$(iwgetid -r)
        if [ $? -eq 0 ]; then
            echo 'N'"%{F$color02 R} 直 %{F- B$color00} $name %{F-}"
        else
            echo 'N'"%{F$color01 R} 睊 %{F-}"
        fi

        sleep 5
    done > $BAR_FIFO &
}

function get_tag() {
    desktops=""

    while true
    do
        old_desktops=$desktops
        desktops=""
        total=$(xdotool get_num_desktops)
        current=$(xdotool get_desktop)
        
        for i in $(seq 0 $((total - 1))); do
            if [ "$i" == "$current" ]; then
                desktops+="%{F$color05 R} ■ %{F- B$color00}"
            else
                desktops+="%{F$color08} ■ %{F-}"
            fi
        done

        if [ "$current" -eq "$total" ]; then
            desktops+="%{B-} %{F$color05 B$color00 R}  %{F- B$color00}"
        fi

        # Don't update unless it's changed
        if [ "$desktops" != "$old_desktops" ]; then
            echo 'W'"$desktops"
        fi

        sleep 0.3
    done > $BAR_FIFO &
}

function get_updates() {
    while true
    do
        ups=$(doas xbps-install -Sun | sed '/hold/d' | wc -l)

        if [[ $ups -gt 0 ]]; then
            echo 'U'"%{F$color04 R}  %{F- B$color00} $ups %{F-}"
        else
            echo 'U'"%{B-}"
        fi

        sleep 30m
    done > $BAR_FIFO &
}

function get_cpu() {
    while true
    do
        use=$(top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}')
        use=$(printf "%d" "$use" 2> /dev/null)

        if [[ $use -gt 70 ]]; then
            echo 'C'"%{F$color01 R} ﬙ %{F- B$color00} ${use}% %{B-}"
        else
            echo 'C'"%{B-}"
        fi

        sleep 5
    done > $BAR_FIFO &
}

function get_music() {
    while true
    do
        # Use playerctl to get any music playing
        song=$(playerctl metadata -f "{{ artist }} - {{ title }}" 2> /dev/null | cut -c -90)

        if [[ "$(playerctl status 2> /dev/null)" == "Playing" ]]; then
            echo 'M'"%{F$color09 R}  %{F- B$color00} ${song} %{B-}"
        else
            echo 'M'"%{B-}"
        fi

        sleep 3
    done > $BAR_FIFO &
}
