#!/bin/bash



# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command failed with exit code $?."' EXIT


cd


sudo apt-get install -y tmux vim htop


sudo apt-get install curl
cd
curl -L https://github.com/convox/convox/releases/latest/download/convox-linux -o /tmp/convox
sudo mv /tmp/convox /usr/local/bin/convox
sudo chmod 755 /usr/local/bin/convox
convox -v


if [ -x "$(command -v kubectl)" ]; then
	echo 'Purging all kubernetes data.'
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	
	sudo snap remove microk8s --purge
else
  echo 'Kubernetes not installed. Exiting.'
  exit
fi

if ! [ -x "$(command -v kubectl)" ]; then
	echo "Installing kubernetes"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	sudo snap install microk8s --classic --channel=1.13/stable
	echo "Enabling DNS on Kubernetes. Sleeping for 30 seconds. Click ctrl+C to abort script." 
	sleep 30s
	sudo usermod -a -G microk8s ${USER}
	su ${USER}

	export PATH="${PATH}:/snap/bin"
	PATH="${PATH}:/snap/bin"

	microk8s.enable dns storage
	echo "Sleeping for another 30 seconds. Click ctrl+C to abort script." 
	sleep 30s

	microk8s.status --wait-ready
	mkdir -p ~/.kube
	microk8s.config > ~/.kube/config
	sudo snap restart microk8s
	sudo snap alias microk8s.kubectl kubectl
	kubectl config view
else
  echo 'Kubernetes is already installed. Skipping.'
fi



if ! [[ "$(convox racks)" =~ .*local.* ]]; then
	echo "Installing local rack"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	sudo convox rack install local dev
	sleep 5s
	convox switch local
else
  echo 'Local rack is already installed. Skipping.'
fi



