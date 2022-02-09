#!/bin/sh

for node_i in $(bspc query -N -n .hidden) 
do
    bspc node $node_i --flag hidden=off
done
