#!/bin/bash



# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command failed with exit code $?."' EXIT


cd


sudo apt-get install -y tmux vim htop


if ! [ -x "$(command -v docker)" ]; then
	echo "Installing Docker"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	sudo apt install -y docker.io 
	docker --version
	sudo systemctl enable docker


	sudo usermod -aG docker ${USER}

	echo "Installing Docker"
	sudo apt install -y docker-compose
else
  echo 'Docker is already installed. Skipping.'
fi


if ! [ -x "$(command -v convox)" ]; then
	echo "Installing convox"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	sudo apt-get install -y curl
	curl -L https://convox.com/cli/linux/convox -o /tmp/convox
	sudo mv /tmp/convox /usr/local/bin/convox
	sudo chmod 755 /usr/local/bin/convox
else
  echo 'Convox is already installed. Skipping.'
fi


if ! [ -x "$(command -v kubectl)" ]; then
	echo "Installing kubernetes"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	sudo snap install microk8s --classic --channel=1.13/stable
	echo "Enabling DNS on Kubernetes. Sleeping for 30 seconds. Click ctrl+C to abort script." 
	sleep 30s
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

	sudo convox rack install local
	convox switch local
else
  echo 'Local rack is already installed. Skipping.'
fi


if ! test -f "/usr/share/ca-certificates/convox/convox.crt"; then
	echo 'Installing convox certificates'
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s


	kubectl get secret/ca -n convox-system -o jsonpath="{.data.tls\.crt}" | base64 -d > /tmp/ca
	sudo mkdir /usr/share/ca-certificates/convox
	sudo mv /tmp/ca /usr/share/ca-certificates/convox/convox.crt
	sudo bash -c 'echo "convox/convox.crt" >> /etc/ca-certificates.conf'
	sudo update-ca-certificates
	sudo snap restart microk8s
	sudo service docker restart
else
  echo 'Convox cert already installed. Skipping.'
fi


if ! [ -x "$(command -v aws)" ]; then
	echo "Installing aws"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	sudo apt install -y python3-pip
	pip3 install awscli --upgrade --user
else
  echo 'AWS is already installed. Skipping.'
fi



echo "copying secrets"
cp -rf ~/Work/docs/secrets/.aws ~/.aws
#cp -rf ~/Work/docs/secrets/.ssh ~/.ssh


echo "Finished script. Please reboot."
