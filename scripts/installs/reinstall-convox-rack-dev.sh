#!/bin/bash



# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command failed with exit code $?."' EXIT


cd


sudo apt-get install -y tmux vim htop curl


if [[ "$(convox racks)" =~ .*local.* ]]; then
	echo "Uninstalling local rack"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

    convox rack uninstall dev
    sleep 5s
else
  echo 'Local rack is already uninstalled. Skipping.'
fi


sudo rm -rf ~/.config/convox
sudo rm -rf /root/.config/convox/

cd
curl -L https://github.com/convox/convox/releases/latest/download/convox-linux -o /tmp/convox
sudo mv /tmp/convox /usr/local/bin/convox
sudo chmod 755 /usr/local/bin/convox
convox -v


if [ -x "$(command -v terraform)" ]; then
	echo 'Purging all terraform data.'
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	
	sudo apt-get purge -y terraform
	sudo rm -rf ~/.terraform.d
	sudo rm -rf /root/.terraform.d
fi

if ! [ -x "$(command -v terraform)" ]; then
	echo "Installing terraform"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	cd
	sudo apt-get install -y terraform
	sleep 60s

else
  echo 'terraform is already installed. Skipping.'
fi



if [ -x "$(command -v kubectl)" ]; then
	echo 'Purging all kubernetes data.'
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	
	sudo snap remove microk8s --purge
	sudo rm -rf ~/.kube
	sudo rm -rf /usr/libexec/kubernetes
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

    convox rack install local dev
	sleep 5s
	convox switch dev
else
  echo 'Local rack is already installed. Skipping.'
fi



