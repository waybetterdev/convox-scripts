#!/bin/bash

# ~/Work/docs/scripts/installs/back-up.sh

date=$(date '+%Y-%m-%d-%H-%M')
cd ~/Work/backups
mkdir "$date"


cd ~
sudo zip -r home.zip ~/.ssh ~/.aws .gitconfig .bash_aliases .bash_profile
ls -la
sudo mv home.zip "/home/$USER/Work/backups/$date"

cd ~/Work/wb-services/kraken/superlocal
sudo zip -r mysql.zip data
sudo mv mysql.zip "/home/$USER/Work/backups/$date"

cd ~/Work
sudo zip -r wb-services.zip wb-services
sudo mv  wb-services.zip "/home/$USER/Work/backups/$date"

cd /var
sudo zip -r www.zip www
sudo mv www.zip "/home/$USER/Work/backups/$date"


sudo cp /var/www/phpmyadmin/config.inc.php "/home/$USER/Work/backups/$date"

cd "/home/$USER/Work/backups/$date"
sudo chmod 777 -R *