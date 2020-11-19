#!/bin/bash



# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command failed with exit code $?."' EXIT


cd


sudo apt-get install -y tmux vim htop curl

sudo rm -rf ~/.config/convox
sudo rm -rf /root/.config/convox/


if [ -x "$(command -v kubectl)" ]; then
	echo 'Purging all kubernetes data.'
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	
	sudo snap remove microk8s --purge
	rm -rf ~/.kube
fi

if ! [ -x "$(command -v kubectl)" ]; then
	~/Work/docs/scripts/installs/install-kubernetes.sh
	sleep 60s
else
  echo 'Kubernetes is already installed. Skipping.'
fi



if ! [[ "$(convox racks)" =~ .*local.* ]]; then
	echo "Installing local rack"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	sudo convox rack install local
	convox switch local
else
  echo 'Local rack is already installed. Skipping.'
fi



