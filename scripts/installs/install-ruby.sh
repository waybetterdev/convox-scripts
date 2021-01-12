#!/bin/bash

# Set variables
SCRIPT_USER=$SUDO_USER

# Checking if script running with sudo
if [[ $(id -u) -ne 0 ]]
    then echo "Please run with sudo ..."
    exit 1
fi

echo 'Well, there we go then! Running the script...'

# Update Ubuntu and install core libraries
# add-apt-repository main
# add-apt-repository universe
# add-apt-repository restricted
# add-apt-repository multiverse
# apt update
apt install -y curl unzip wget  git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev

# Install yarn
npm -g install yarn


# Install rbenv
cd /usr/local
git clone http://github.com/rbenv/rbenv.git rbenv
chgrp -R staff rbenv
chmod -R g+rwxXs rbenv

echo 'export RBENV_ROOT=/usr/local/rbenv' >> /home/"$SCRIPT_USER"/.bashrc
echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /home/"$SCRIPT_USER"/.bashrc
echo 'eval "$(rbenv init -)"' >> /home/"$SCRIPT_USER"/.bashrc

echo 'export RBENV_ROOT=/usr/local/rbenv' >> /root/.bashrc
echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /root/.bashrc
echo 'eval "$(rbenv init -)"' >> /root/.bashrc

export RBENV_ROOT=/usr/local/rbenv
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"

# Install ruby-build
git clone https://github.com/rbenv/ruby-build.git /root/.rbenv/plugins/ruby-build
git clone https://github.com/rbenv/ruby-build.git /home/"$SCRIPT_USER"/.rbenv/plugins/ruby-build

echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> /root/.bashrc
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> /home/"$SCRIPT_USER"/.bashrc

export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# Install Ruby
rbenv install -v 2.6.2
rbenv install -v 2.6.3
rbenv global 2.6.2

gem install bundler
gem install 'pry' 'highline' 'colored' 'colored' 'ruby-terminfo' 'tty-prompt' 'pry-byebug'
rbenv rehash


# Change folder and files owner
chown -R "$SCRIPT_USER":"$SCRIPT_USER" /home/"$SCRIPT_USER"
chown -R "$SCRIPT_USER":root /usr/local/rbenv

echo 'Installation complete'
