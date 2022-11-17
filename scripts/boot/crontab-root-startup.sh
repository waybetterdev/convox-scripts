#!/bin/bash

#####################################################################
# Script that fixes dns for convox on startup
# HOT TO INSTALL
# 1. run 'sudo crontab -e'
# 2. Add line  `@reboot /bin/bash /home/dev/Work/docs/scripts/boot/crontab-root-startup.sh`
# 3. Create folder /home/dev/tmux-boot-logs/ for logs
#####################################################################


if [[ "$(microk8s.status)" =~ 'microk8s is not running' ]]; then
  microk8s.start
  echo $(date) + "microk8s not running. Starting it. " >> /home/dev/tmux-boot-logs/root-startup.txt 2>&1
  
  echo $(date) + "waiting for microk8s to start. " >> /home/dev/tmux-boot-logs/root-startup.txt 2>&1
  microk8s.status --wait-ready
  echo $(date) + "microk8s is now running. " >> /home/dev/tmux-boot-logs/root-startup.txt 2>&1
else
  echo $(date) + 'microk8s already running. Skipping.' >> /home/dev/tmux-boot-logs/root-startup.txt 2>&1
fi

echo $(date) + "Fixing DNS: " >> /home/dev/tmux-boot-logs/root-startup.txt 2>&1
iptables -P FORWARD ACCEPT >> /home/dev/tmux-boot-logs/root-startup.txt 2>&1
echo $(date) + "done" >> /home/dev/tmux-boot-logs/root-startup.txt 2>&1
