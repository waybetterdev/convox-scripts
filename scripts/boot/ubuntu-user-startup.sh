#!/bin/bash


#####################################################################
# script that starts convox in a tmux terminal
# HOT TO INSTALL
# 1. Add /home/dev/Work/docs/configs/linux-user-configs/crontab-root-startup.sh to root crontab (open script to see help)
#
# 2. Make terminal run at user login
#    - Press the Super key (windows key).
#    - Type "Startup Applications"
#    - Click on the Startup Applications option
#    - Click "Add"
#    	In the "name" field, type Terminal
#    	In the "command" field, type gnome-terminal
#	Command to add: /usr/bin/gnome-terminal --command '/home/dev/Work/docs/configs/linux-user-configs/ubuntu-user-startup.sh'
# 3. Check that both crontab-root-startup.sh and ubuntu-user-startup.sh have run permission
# 4. Create folder /home/dev/tmux-boot-logs/ for logs
#####################################################################


# Ensure the environment is available
export HOME="/home/dev/"
export PATH="/home/dev/.rbenv/plugins/ruby-build/bin:/home/dev/.rbenv/shims:/home/dev/.rbenv/bin:/home/dev/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"

source /home/dev/.bashrc
source /home/dev/.bash_aliases
source /home/dev/.profile


alias stlwbtmux="~/Work/docs/configs/linux-user-configs/tmux_new_session.sh"


#ruby -v >> /home/dev/tmux-boot-logs/ruby.txt 2>&1
echo $(date) + ": sleeping for 120 seconds and then starting wbtmux" >> /home/dev/tmux-boot-logs/wbtmux.txt 2>&1
sleep 120

echo $(date) + "Fixing DNS: "  >> /home/dev/tmux-boot-logs/wbtmux.txt 2>&1
convox registries add 247028141071.dkr.ecr.us-west-2.amazonaws.com AWS $(aws ecr get-login-password --region us-west-2 --profile prod) >> /home/dev/tmux-boot-logs/wbtmux.txt 2>&1

echo $(date) + ": running wbtmux" >> /home/dev/tmux-boot-logs/wbtmux.txt 2>&1
ruby /home/dev/Work/docs/configs/linux-user-configs/bin/wbtmux -r mysql,user,auth,bill,falkor,graphql,admin-auth,admin-web,metric,notify,member,runbet,social -o dietbet,hub -w >> /home/dev/tmux-boot-logs/wbtmux.txt 2>&1

#echo $(date) + ": opening tmux" >> /home/dev/tmux-boot-logs/wbtmux.txt 2>&1
#tmux attach -t lconvox >> /home/dev/tmux-boot-logs/wbtmux.txt 2>&1



#    "mysql"       => 'kraken/superlocal',
#    "user"        => 'wb-user-service',
#    "auth"        => 'wb-auth-service',
#    "bill"        => 'wb-billing-service',
#    "graphql"     => 'wb-graphql-service',
#    "dietbet"     => 'dietbet-game-service',
#    "hub"         => 'wb-hub',
#    "admin-auth"  => 'wb-admin-auth-service',
#    "admin-web"   => 'wb-admin-web',
#    "metric"      => 'wb-metric-service',
#    "notify"      => 'wb-notify-service',
#    "member"      => 'wb-membership-service',
#    "falkor"      => 'falkor-game-service',
#    "runbet"      => 'runbet-game-service',
#    "social"      => 'wb-social-service',



