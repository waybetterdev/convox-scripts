#!/bin/bash



# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT


cd


if ! [ -x "$(command -v aws)" ]; then
	echo "Installing aws"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	sudo apt install -y python3-pip
	pip3 install awscli --upgrade --user
else
  echo 'AWS is already installed. Skipping.'
fi



if ! [ -x "$(command -v ruby)" ]; then
	~/Work/docs/scripts/installs/install-ruby.sh
else
  echo 'Ruby 2.6.2 is already installed. Skipping.'
fi


if ! [ -x "$(command -v docker)" ]; then
	~/Work/docs/scripts/installs/install-docker.sh
else
  echo 'Docker is already installed. Skipping.'
fi


if ! [ -x "$(command -v terraform)" ]; then
	echo "Installing terraform"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s


	cd
	curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
	sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
	sudo apt-get update && sudo apt-get install terraform

else
  echo 'terraform is already installed. Skipping.'
fi


if ! [ -x "$(command -v convox)" ]; then
	echo "Installing convox"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	sudo apt-get install curl
	cd
	curl -L https://github.com/convox/convox/releases/latest/download/convox-linux -o /tmp/convox
	sudo mv /tmp/convox /usr/local/bin/convox
	sudo chmod 755 /usr/local/bin/convox
	convox -v

else
  echo 'Convox is already installed. Skipping.'
fi


if ! [ -x "$(command -v kubectl)" ]; then
	~/Work/docs/scripts/installs/install-kubernetes.sh
else
  echo 'Kubernetes is already installed. Skipping.'
fi



if ! [[ "$(convox racks)" =~ .*local.* ]]; then
	echo "Installing local rack"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	sudo convox rack install local dev
	convox switch local

	sudo mkdir -p /usr/lib/systemd/resolved.conf.d
	sudo bash -c "printf '[Resolve]\nDNS=$(kubectl get service/resolver-external -n dev-system -o jsonpath="{.spec.clusterIP}")\nDomains=~convox' > /usr/lib/systemd/resolved.conf.d/convox.conf"
	systemctl daemon-reload
	systemctl restart systemd-networkd systemd-resolved

else
  echo 'Local rack is already installed. Skipping.'
fi


if ! test -f "/usr/share/ca-certificates/convox/convox.crt"; then
	echo 'Installing convox certificates'
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s


	kubectl get secret/ca -n dev-system -o jsonpath="{.data.tls\.crt}" | base64 -d > /tmp/ca
	sudo mkdir /usr/share/ca-certificates/convox
	sudo mv /tmp/ca /usr/share/ca-certificates/convox/convox.crt
	sudo bash -c 'echo "convox/convox.crt" >> /etc/ca-certificates.conf'
	sudo update-ca-certificates
	sudo snap restart microk8s
	sudo service docker restart

else
  echo 'Convox cert already installed. Skipping.'
fi



echo "copying secrets"
cp -rf ~/Work/docs/secrets/.aws ~/.aws
#cp -rf ~/Work/docs/secrets/.ssh ~/.ssh


echo "Finished script. Please reboot."
