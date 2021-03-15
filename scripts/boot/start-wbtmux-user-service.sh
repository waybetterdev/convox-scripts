#!/bin/bash

env DISPLAY=:0 /usr/bin/xfce4-terminal --maximize -e 'bash -c "/home/dev/Work/docs/scripts/boot/restart-tmux-session.sh; exit 0"' -T "Local Convox"

