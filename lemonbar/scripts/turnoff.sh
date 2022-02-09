#!/usr/bin/env bash

barheight=24
dmenufont="curie:size=12"

normbgcolor="#2b303b"
normfgcolor="#4f5b66"
                             
selbgcolor="#2b303b"
selfgcolor="#a7adba"
                             
function restart() {
    gksu reboot 
}

function lock() {
    $HOME/.config/owl/scripts/lock/lock.sh
}

function shutdown() {
    gksu poweroff
}

ret=$(echo -e "Lock\nShutdown\nRestart" | dmenu -h $barheight -m 0 -fn $dmenufont -nb $normbgcolor -nf $normfgcolor -sb $selbgcolor -sf $selfgcolor)
case "$ret" in
    "Lock")
        lock
        ;;
    "Shutdown")
        shutdown
        ;;
    "Restart")
        restart
        ;;
esac
