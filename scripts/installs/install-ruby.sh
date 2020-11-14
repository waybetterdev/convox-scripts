#!/bin/bash



# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT


cd



echo "Installing ruby 2.6.2"
echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
sleep 10s


echo "Installing yarn"
cd
sudo apt install -y curl
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list



sudo apt-get install -y git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn


echo "Installing rbenv"
cd
rm -rf ~/.rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL <<EOF1



echo "Adding rbenv to PATH"
cd
rm -rf ~/.rbenv/plugins/ruby-build
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL <<EOF2


sudo apt-get install -y libssl-dev libreadline-dev
rbenv install 2.6.2
rbenv install 2.6.3
rbenv init
rbenv global 2.6.2
rbenv shell 2.6.2
ruby -v

gem install bundler
gem install 'pry' 'highline' 'colored' 'colored' 'ruby-terminfo'

EOF2
EOF1
