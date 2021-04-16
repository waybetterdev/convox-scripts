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


  sudo apt-get update && sudo apt-get install -y vim curl less mysql-client

  sudo apt install curl 
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash


  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  source ~/.bashrc
  source ~/.profile

  nvm list-remote

  nvm install node 
else
  echo 'nvm is already installed. Skipping.'
fi

