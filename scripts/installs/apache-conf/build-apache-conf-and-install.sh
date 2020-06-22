#!/bin/bash

php print-wbproxy-ssl-config.php


echo "Installing apache conf files"
echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
sleep 3s
sudo rm /etc/apache2/sites-enabled/000-default.conf 
sudo cp -v wb-proxy.conf /etc/apache2/sites-enabled/wb-proxy.conf
sudo cp -v wb-proxy-ssl.conf /etc/apache2/sites-enabled/wb-proxy-ssl.conf


echo "Restarting apache"
sudo systemctl restart apache2.service
