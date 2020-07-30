#!/bin/bash

# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT

echo "`dirname "$0"`/generate-wbproxy-ssl-config.php"

php "`dirname "$0"`/generate-wbproxy-ssl-config.php"

echo "Installing apache conf files"
echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
sleep 3s
if test -f "/etc/apache2/sites-enabled/000-default.conf "; then
	echo "Deleting rm /etc/apache2/sites-enabled/000-default.conf." 
	sudo rm /etc/apache2/sites-enabled/000-default.conf 
fi

sudo cp -v "`dirname "$0"`/../../../local-settings/wb-proxy.conf" /etc/apache2/sites-enabled/wb-proxy.conf
sudo cp -v "`dirname "$0"`/../../../local-settings/wb-proxy-ssl.conf" /etc/apache2/sites-enabled/wb-proxy-ssl.conf


echo "Restarting apache"
sudo systemctl restart apache2.service
