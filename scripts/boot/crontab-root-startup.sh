#!/bin/bash

#####################################################################
# Script that fixes dns for convox on startup
# HOT TO INSTALL
# 1. run 'sudo crontab -e'
# 2. Add line  `@reboot /bin/bash /home/dev/Work/docs/configs/linux-user-configs/crontab-root-startup.sh`
# 3. Create folder /home/dev/tmux-boot-logs/ for logs
#####################################################################

sudo echo $(date) + "Fixing DNS: " && sudo iptables -P FORWARD ACCEPT && echo $(date) + "done" >> /home/dev/tmux-boot-logs/root-startup.txt 2>&1
