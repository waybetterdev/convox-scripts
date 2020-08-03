#!/bin/bash



# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT


cd


sudo apt-get install -y tmux vim htop

if ! [ -x "$(command -v ruby)" ]; then
	echo "Installing ruby 2.6.2"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	sudo apt install -y curl
	curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list


	sudo apt-get install -y git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn

	if ! [ -x "$(command -v rbenv)" ]; then
		echo "Installing rbenv"
		cd
		git clone https://github.com/rbenv/rbenv.git ~/.rbenv
		echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
		echo 'eval "$(rbenv init -)"' >> ~/.bashrc
		exec $SHELL
	else
	  echo 'rbenv is already installed. Skipping.'
	fi

	if ! [ -x "$(command -v ruby-build)" ]; then
		echo "Adding rbenv to PATH"
		cd
		git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
		echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
		exec $SHELL
	else
	  echo 'ruby-build is already installed. Skipping.'
	fi

	sudo apt-get install -y libssl-dev libreadline-dev
	rbenv install 2.6.2
	rbenv global 2.6.2
	rbenv shell 2.6.2
	ruby -v

	gem install bundler
	gem install 'pry' 'highline' 'colored' 'colored' 'ruby-terminfo'

	echo "Also installing ruby 2.6.3 for kraken scripts"
	rbenv install 2.6.3

	gem install bundler
	gem install 'pry' 'highline' 'colored' 'colored' 'ruby-terminfo'

else
  echo 'Ruby 2.6.2 is already installed. Skipping.'
fi



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


if ! [ -x "$(command -v terraform)" ]; then
	echo "Installing terraform"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s


	cd
	sudo apt install unzip
	wget https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip
	unzip terraform_0.12.29_linux_amd64.zip
	sudo mv terraform /usr/local/bin/
	rm terraform_0.12.29_linux_amd64.zip
	terraform -v

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
	echo "Installing kubernetes"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	sudo snap install microk8s --classic --channel=1.13/stable
	echo "Enabling DNS on Kubernetes. Sleeping for 30 seconds. Click ctrl+C to abort script." 
	sleep 30s
	microk8s.enable dns storage
	echo "Sleeping for another 30 seconds. Click ctrl+C to abort script." 
	sleep 30s

	export PATH="${PATH}:/snap/bin"
	PATH="${PATH}:/snap/bin"

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
