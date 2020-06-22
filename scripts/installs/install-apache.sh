#!/bin/bash



# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT


if ! [ -x "$(command -v apache2)" ]; then
	echo "Installing apache2"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	sudo apt install -y apache2
	sudo a2enmod ssl
	sudo a2enmod proxy
	sudo a2enmod proxy_http
	sudo a2enmod headers
	sudo a2enmod rewrite
	sudo a2enmod expires
else
  echo 'apache2 is already installed. Skipping.'
fi

if ! test -f "/etc/ssl/certs/apache-office-selfsigned.crt"; then
	echo "Copying certificates to apache"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s
	
	sudo cp -v ~/Work/docs/certs/apache/office-selfsigned/office-selfsigned.crt /etc/ssl/certs/apache-office-selfsigned.crt
	sudo cp -v ~/Work/docs/certs/apache/office-selfsigned/office-selfsigned.key /etc/ssl/private/apache-office-selfsigned.key
	sudo cp -v ~/Work/docs/certs/apache/waybetterdev-selfsigned/waybetterdev-selfsigned.crt /etc/ssl/certs/apache-waybetterdev-selfsigned.crt
	sudo cp -v ~/Work/docs/certs/apache/waybetterdev-selfsigned/waybetterdev-selfsigned.key /etc/ssl/private/apache-waybetterdev-selfsigned.key
	sudo cp -v ~/Work/docs/certs/apache/ninja-selfsigned/ninja-selfsigned.crt /etc/ssl/certs/apache-ninja-selfsigned.crt
	sudo cp -v ~/Work/docs/certs/apache/ninja-selfsigned/ninja-selfsigned.key /etc/ssl/private/apache-ninja-selfsigned.key
	sudo cp -v ~/Work/docs/certs/apache/vbox-selfsigned/vbox-selfsigned.crt /etc/ssl/certs/apache-vbox-selfsigned.crt
	sudo cp -v ~/Work/docs/certs/apache/vbox-selfsigned/vbox-selfsigned.key /etc/ssl/private/apache-vbox-selfsigned.key
	sudo cp -v ~/Work/docs/certs/apache/local-selfsigned/local-selfsigned.crt /etc/ssl/certs/apache-local-selfsigned.crt
	sudo cp -v ~/Work/docs/certs/apache/local-selfsigned/local-selfsigned.key /etc/ssl/private/apache-local-selfsigned.key
else
  echo 'Apache certificates already installed. Skipping.'
fi

if ! test -f "/usr/share/ca-certificates/waybetterdev-selfsigned-rootCA.crt"; then
	echo "Installing root certificates"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s
	
	
	sudo cp -v ~/Work/docs/certs/apache/waybetterdev-selfsigned/waybetterdev-selfsigned-rootCA.crt /usr/share/ca-certificates/waybetterdev-selfsigned-rootCA.crt
	sudo cp -v ~/Work/docs/certs/apache/ninja-selfsigned/ninja-selfsigned-rootCA.crt /usr/share/ca-certificates/ninja-selfsigned-rootCA.crt
	sudo cp -v ~/Work/docs/certs/apache/office-selfsigned/office-selfsigned-rootCA.crt /usr/share/ca-certificates/office-selfsigned-rootCA.crt
	sudo cp -v ~/Work/docs/certs/apache/local-selfsigned/local-selfsigned-rootCA.crt /usr/share/ca-certificates/local-selfsigned-rootCA.crt
	sudo bash -c 'echo "waybetterdev-selfsigned-rootCA.crt" >> /etc/ca-certificates.conf'
	sudo bash -c 'echo "ninja-selfsigned-rootCA.crt" >> /etc/ca-certificates.conf'
	sudo bash -c 'echo "office-selfsigned-rootCA.crt" >> /etc/ca-certificates.conf'
	sudo bash -c 'echo "local-selfsigned-rootCA.crt" >> /etc/ca-certificates.conf'
	sudo update-ca-certificates
else
  echo 'Root certificates already installed. Skipping.'
fi

if ! [ -x "$(command -v php)" ]; then
	echo "Installing php 7.4 and mysqli"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	
	sudo apt-get install -y libapache2-mod-php7.4 
	sudo apt-get install -y php-mbstring php7.4-curl
	sudo a2enmod php7.4 
	sudo apt-get install -y php7.4-mysqli
else
  echo 'php is already installed. Skipping.'
fi


if ! test -d "/var/www/wb-proxy"; then
	echo "Installing https-proxy and phpmyadmin"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

	echo "Creating /var/www path"
	sudo mkdir /var/www/wb-proxy
	sudo mkdir /var/www/wb-proxy/logs
	echo "Installing phpmyadmin"
	sudo cp -vr ~/Work/docs/apps/phpmyadmin /var/www/phpmyadmin
	sudo chmod 777 -R /var/www
else
  echo 'phpmyadmin is already installed. Skipping.'
fi

if ! test -f "/etc/apache2/sites-enabled/wb-proxy-ssl.conf"; then
	echo "Installing apache conf files"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s
	sudo rm /etc/apache2/sites-enabled/000-default.conf 
	sudo cp -v ~/Work/docs/configs/apache-proxy/wb-proxy.conf /etc/apache2/sites-enabled/wb-proxy.conf
	sudo cp -v ~/Work/docs/configs/apache-proxy/wb-proxy-ssl.conf /etc/apache2/sites-enabled/wb-proxy-ssl.conf
	sudo systemctl restart apache2.service
else
  echo 'Apache conf file is already installed. Skipping.'
fi


echo "Restarting apache"
sudo systemctl restart apache2.service
