#!/bin/fish

#--- Variables ---#

# Date and time
set DATE (date +"%A %d %B")

# Time
set TIME (date +"%R")" " # Adds a gap at the end of the bar

# Status to be displayed

# \x02 means the icons, and the following ones, will use the colors in
# [SchemeSel] con dwm's config.h, making them lighter. This is done in case
# one parameter reaches dangerous values so we can change it with \x03
# without affecting the rest - yeah it's programmed in a weird way, don't ask.

set STATUS $DATE", "$TIME

# Piping it to the root X window, which dwm uses as status bar
xsetroot -name "$STATUS"

# Just an arbitrary timer
sleep 60
