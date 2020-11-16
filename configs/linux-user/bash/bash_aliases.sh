#!/bin/bash

/bin/bash ~/Work/docs/secrets/bash-secrets.sh

#awscli
export PATH="${PATH}:$HOME/.local/bin"
PATH="${PATH}:$HOME/.local/bin"

#utils
export PATH="${PATH}:$HOME/Work/docs/scripts/ruby"
PATH="${PATH}:$HOME/Work/docs/scripts/ruby"

#wb-service paths
export PATH="${PATH}:$HOME/Work/wb-services/kraken/bin"
PATH="${PATH}:$HOME/Work/wb-services/kraken/bin"

#mikrok8s
# export PATH="${PATH}:/snap/bin"
# PATH="${PATH}:/snap/bin"


alias rb='source ~/.bashrc'
alias be='bundle exec'
alias kk='kmd-local'

#diretory utils
#list directory and show path
alias lcd='ls -a; echo "      ";echo "          ***" $PWD  "***";'

# move to local app and list files
alias cddocs='cd ~/Work/docs;lcd'
alias cdservices='cd ~/Work/wb-services;lcd'
alias cdsuperlocal='cd ~/Work/wb-services/kraken/superlocal;lcd'
alias cduser='cd ~/Work/wb-services/wb-user-service;lcd'
alias cdnotify='cd ~/Work/wb-services/wb-notify-service;lcd'
alias cdbilling='cd ~/Work/wb-services/wb-billing-service;lcd'
alias cdmetric='cd ~/Work/wb-services/wb-metric-service;lcd'
alias cdmember='cd ~/Work/wb-services/wb-membership-service;lcd'
alias cdfalkor='cd ~/Work/wb-services/falkor-game-service;lcd'
alias cdhub='cd ~/Work/wb-services/wb-hub;lcd'
alias cdauth='cd ~/Work/wb-services/wb-auth-service;lcd'
alias cdadminauth='cd ~/Work/wb-services/wb-admin-auth-service;lcd'
alias cdgraphql='cd ~/Work/wb-services/wb-graphql-service;lcd'
alias cdadminweb='cd ~/Work/wb-services/wb-admin-web;lcd'
alias cddietbet='cd /var/www/dietbet;lcd'
alias cddietbetdev='cd /var/www/dietbet_dev;lcd'
alias cddietbetprod='cd /var/www/dietbet_prod;lcd'
alias cdstepbet='cd /var/www/stepbet;lcd'
alias cdstepbetdev='cd /var/www/stepbet_dev;lcd'
alias cdstepbetprod='cd /var/www/stepbet_prod;lcd'

#utils
alias notepad=sublime-text.subl


alias reloadaliases="cp -f ~/Work/docs/configs/linux-user/bash/bash_aliases.sh ~/.bash_aliases && cp -f ~/Work/docs/configs/linux-user/bash/bash_profile.sh ~/.bash_profile && source ~/.bash_aliases && source ~/.bash_profile && echo 'reloaded aliases and profile from linux-user folder'"

alias restartapache='sudo systemctl restart apache2.service'
alias stopapache='sudo systemctl stop apache2.service'


alias convoxdnsfix="sudo echo 'fixing iptables' && sudo iptables -P FORWARD ACCEPT && echo 'done'"
alias convoxawsfix="convox registries add 247028141071.dkr.ecr.us-west-2.amazonaws.com AWS $(aws ecr get-login-password --region us-west-2 --profile prod)"
alias convoxenvreloadall="~/Work/docs/scripts/bash/convox-reload-all-envs.sh"
alias convoxymlreloadall="~/Work/docs/scripts/bash/convox-reload-all-local-ymls.sh"
