

1. copy contents of ~/Work/docs/config/apache-proxy.txt to /etc/hosts (places convox server IP)
2. run install-apache.sh
3. configure git and run clone-all-git-repositories.sh
4. run install-convox.sh
5. replace your user name in /bash_profile.sh and run:
 cp -f ~/Work/docs/configs/linux-user-configs/bash_aliases.sh ~/.bash_aliases && cp -f ~/Work/docs/configs/linux-user-configs/bash_profile.sh ~/.bash_profile && source ~/.bash_aliases && source ~/.bash_profile && echo 'reloaded aliases and profile from linux-user-configs folder'









 Start mysql container from /kraken/superlocal
cd ~/Work/wb-services/kraken/superlocal
sudo docker-compose up
Open a separate terminal window and continue working there (see dev notes for tmux). List all your convox containers and copy the ID for your mysql container
docker ps
Enter bash in your mysql container
docker exec -it <container id> /bin/bash
Log into mysql with the default user and password
mysql -u root -ptest
Add grant permissions to root@YOUR_IP so that wb-services inside convox containers could access the mysql server from the docker container. 
Note that root is set up to accept only requests from localhost but the convox machines are not localhost. They are considered as outside traffic coming from your own IP
Note: Local IP for VBOx is 10.0.2.15

CREATE USER 'root'@'192.168.100.28' IDENTIFIED BY 'test';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.100.28' WITH GRANT OPTION;
FLUSH PRIVILEGES;


CREATE USER 'root'@'192.168.1.102' IDENTIFIED BY 'test';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.1.102' WITH GRANT OPTION;
FLUSH PRIVILEGES;



 - migrate and see node JS app:
export NODE_ENV=development; ./node_modules/.bin/sequelize db:migrate
npm run seed
