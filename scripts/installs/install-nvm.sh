#!/bin/bash


# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command failed with exit code $?."' EXIT


if ! [ -x "$(command -v nvm)" ]; then
	echo "Installing nvm"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s


  sudo apt-get update && apt-get install -y \
    vim \
    curl \
    less \
    mysql-client

  sudo apt install curl 
  curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 

  source ~/.profile
else
  echo 'nvm is already installed. Skipping.'
fi

