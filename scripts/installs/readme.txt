

1. copy contents of ~/Work/docs/config/apache-proxy.txt to /etc/hosts (places convox server IP)
2. run install-apache.sh
3. configure git and run clone-all-git-repositories.sh
4. run install-convox.sh
5. replace your user name in /bash_profile.sh and run:
 cp -f ~/Work/docs/configs/linux-user-configs/bash_aliases.sh ~/.bash_aliases && cp -f ~/Work/docs/configs/linux-user-configs/bash_profile.sh ~/.bash_profile && source ~/.bash_aliases && source ~/.bash_profile && echo 'reloaded aliases and profile from linux-user-configs folder'