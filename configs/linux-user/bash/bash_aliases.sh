#!/bin/bash

chmod +x ~/Work/docs/secrets/bash-secrets.sh
. ~/Work/docs/secrets/bash-secrets.sh

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
alias cdquitbet='cd ~/Work/wb-services/quitbet-game-service;lcd'
alias cddietbet='cd /var/www/dietbet;lcd'
alias cddietbetdev='cd /var/www/dietbet-dev;lcd'
alias cddietbetprod='cd /var/www/dietbet-prod;lcd'
alias cdstepbet='cd /var/www/stepbet;lcd'
alias cdstepbetdev='cd /var/www/stepbet-dev;lcd'
alias cdstepbetprod='cd /var/www/stepbet-prod;lcd'

alias cdmobile='cd ~/Work/mobile-apps;lcd'
alias cdwaybettermobile='cd ~/Work/mobile-apps/waybetter-mobile;lcd'
alias cdquitbetmobile='cd ~/Work/mobile-apps/quitbet-mobile;lcd'
alias cddietbetmobile='cd ~/Work/mobile-apps/dietbet-mobile;lcd'
alias cdstepbetmobile='cd ~/Work/mobile-apps/stepbet-mobile;lcd'


#utils
alias notepad=sublime-text.subl

alias npmstartservice="lrun bash -ic 'nvm use && nvm ls && npm start'"
alias npminstallservice="bash -ic 'nvm install && nvm ls && lrun npm install'"
alias npmmigrate="lrun bash -ic 'NODE_ENV=test ./node_modules/.bin/sequelize db:migrate'"

alias lintfix="npx eslint ./src --fix"

alias reloadaliases="cp -f ~/Work/docs/configs/linux-user/bash/bash_aliases.sh ~/.bash_aliases && cp -f ~/Work/docs/configs/linux-user/bash/bash_profile.sh ~/.bash_profile && source ~/.bash_aliases && source ~/.bash_profile && echo 'reloaded aliases and profile from linux-user folder'"

alias restartapache='sudo systemctl restart apache2.service'
alias stopapache='sudo systemctl stop apache2.service'
alias rebuildapacheproxy='~/Work/docs/scripts/installs/apache-conf/build-apache-conf-and-install.sh'


alias convoxdnsfix="sudo echo 'fixing iptables' && sudo iptables -P FORWARD ACCEPT && echo 'done'"
alias convoxawsfix="convox registries add 247028141071.dkr.ecr.us-west-2.amazonaws.com AWS $(aws ecr get-login-password --region us-west-2 --profile prod)"
alias convoxenvreloadall="~/Work/docs/scripts/bash/convox-reload-all-envs.sh"
alias convoxymlreloadall="~/Work/docs/scripts/bash/convox-reload-all-local-ymls.sh"

alias 7zmaxcompression="sudo 7z a -t7z -m0=lzma2 -mx=9 -aoa"

alias printnodeapps="netstat -tulpn | grep node"
