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


alias rb='source ~/.bashrc'
alias be='bundle exec'
alias kk='kmd-local'


#utils
alias notepad=sublime-text.subl


alias reloadaliases="cp -f ~/Work/docs/configs/linux-user/bash/bash_aliases.sh ~/.bash_aliases && cp -f ~/Work/docs/configs/linux-user/bash/bash_profile.sh ~/.bash_profile && source ~/.bash_aliases && source ~/.bash_profile && echo 'reloaded aliases and profile from linux-user-configs folder'"



alias convoxdnsfix="sudo echo 'fixing iptables' && sudo iptables -P FORWARD ACCEPT && echo 'done'"
alias convoxawsfix="convox registries add 247028141071.dkr.ecr.us-west-2.amazonaws.com AWS $(aws ecr get-login-password --region us-west-2 --profile prod)"
alias convoxenvreloadall="~/Work/docs/scripts/bash/convox-reload-all-envs.sh"
alias convoxymlreloadall="~/Work/docs/scripts/bash/convox-reload-all-local-ymls.sh"
