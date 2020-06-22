


# change the loading requirement of ~/.bashrc as interactive only so tmux alwas loads it
# https://stackoverflow.com/questions/9652126/bashrc-profile-is-not-loaded-on-new-tmux-session-or-window-why
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi



#awscli
export PATH="${PATH}:$HOME/.local/bin"
PATH="${PATH}:$HOME/.local/bin"


#utils
export PATH="${PATH}:$HOME/Work/docs/scripts/ruby"
PATH="${PATH}:$HOME/Work/docs/scripts/ruby"


#wb-service paths
export PATH="${PATH}:$HOME/Work/wb-services/kraken/bin"
PATH="${PATH}:$HOME/Work/wb-services/kraken/bin"