#!/bin/sh

case $BUTTON in
    1) notify-send "$(upower -b | grep percentage)"
esac
