#!/usr/bin/env bash
dir=$(dirname "$0")

source "$dir"/bar_functions.sh
source "$dir"/bar_config.sh

# Bar modules
mLeft="%{l B$color00}"
mRight="%{r}"

# Startup
init_fifo
init_daemons

# Kill all children on exit
trap 'pkill -P $$' EXIT SIGINT SIGTERM

# Main loop that constantly pipes into lemonbar
while read -r line < "$BAR_FIFO"
do
    case $line in
        # Date
        D*)
            currdate="${line#?}";;
        # Network
        N*)
            net="${line#?}";;

        # Battery
        B*)
            bat="${line#?}";;

        # Workspaces
        W*)
            wm="${line#?}";;

        # Updates
        U*)
            ups="${line#?}";;

        M*)
            music="${line#?}";;
    esac
    printf "%s%s%s\n" \
            "${mLeft}${wm}" \
            "${mRight}${ups}%{B-} ${music}%{B-} ${net}%{B-}${bat} %{B-}${currdate} " \
            "%{B- F-}" # Cleanup to prevent colors from mixing up
done | \

lemonbar -d \
         -o 1 \
         -f "$font1" \
         -o 1 \
         -f "$font2" \
         -o '-1' \
         -f "$font3" \
         -g "${width}"x"${height}"+"${x}"+"${y}" \
         -n "$name" \
         -F "$color07"
         # -B "$color00"
