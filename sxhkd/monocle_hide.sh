#!/bin/sh

for node_i in $(bspc query -N -n '.!focused.window' -d focused) 
do
    bspc node $node_i -g hidden
done
bspc node -t ~fullscreen
