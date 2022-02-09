#!/usr/bin/env bash

# Bar
name="bar"
x=18
y=9
height=25
read -r width foo <<< "$(xdotool getdisplaygeometry)"
width=$((width - 2 * x))

# Fonts
# font1="ShureTechMono Nerd Font:pixelsize=13"
font1="dina:pixelsize=12"
font2="FuraCode Nerd Font:pixelsize=13"
font3="IPAGothic:pixelsize=13"
