# convox-scripts

# OP Scripts and their usage
1. `opdeploy` - deployment script for deploying on either of the three servers `api.stepbet.com`, `images.stepbet.com`, `dev.stepbet.com` 
[Docs](/doc/op-scripts.md#op-deploy)

2. `opkonnect` - opens an SSH connection to a server
[Docs](/doc/op-scripts.md#op-konnect)

3. `oplogs` - downloads file logs from servers
[Docs](/doc/op-scripts.md#op-logs)


# NP Scripts and their usage
1. `npenv` - ruby script that builds environment variables for each service. It reads the config file from `./local-settings/np-services-config.rb` and automatically generates domain names for each service so that the services can talk to each other. 

For example, if you mark `user-service` as running locally inside a convox container with 
```
LOCAL_CONVOX_SERVICES = %i[graphql]
```
then all services that talk to `user-service` will access it as `wb-user-service.convox.local`. This route will pass through our apache proxy, which will provide the self-signed certificates needed for SSL.

Usage
You can use `npenv` for editing or writing config files:
`npenv -w -a user` will generate the ENV variables for user service
`npenv -e -a user` will open a text editor and you will be able to change ENV variables for user srevice.



# File structure
1. `/certs/apache` self signed apache certificates used when running a local apache server for proxying requests from OP and NP services
2. `/configs/linux-user/bash/` contains `bash_profile.sh` and `bash_profile.sh` that need to placed in your home folder
3. `/configs/templates/` contains example configuration files
4. `/local-settings/` contains convox yml and env configuration files
5. `/scripts/` contains various ruby, bash scripts

# Installation
Note: Our local development envoronment is Ubuntu LTS 20.04 so all installation scripts are based on it. If you have an Ubuntu or other compatible Debian based ditros, you can use our install scripts. Or otherwise your will need to open the install scripts and run the installation commands that are specific to your Linux.

1. Create a `~/Work/` folder in your home folder and clone this repository as `docs`. Having the exact path `~/Work/docs` is very important because a lof our scripts and configuration files are hardocded to use this path (we plan on fixing this soon).
```
cd ~
mkdir Work
git clone git@github.com:waybetterdev/convox-scripts.git docs
```

Replace your user name in /bash_profile.sh and run this command to install our bash aliases and profile to your user (Note: it will overwrite old profile):
```
cp -f ~/Work/docs/configs/linux-user-configs/bash_aliases.sh ~/.bash_aliases && cp -f ~/Work/docs/configs/linux-user-configs/bash_profile.sh ~/.bash_profile && source ~/.bash_aliases && source ~/.bash_profile && echo 'reloaded aliases and profile from linux-user-configs folder'
```

Copy npmrc and bash secrets to your home folder
```
cp ~/Work/docs/secrets/.npmrc ~/.npmrc
cp ~/Work/docs/secrets/bash-secrets.sh ~/bash-secrets.sh
```


2. Create a `~/Work/wb-services` folder and all repositories for NP microservices.
```
scripts/installs/clone-all-git-reposes.sh
```

3. Install ruby 2.7, 2.6 nia rbenv. 
```
scripts/installs/install-ruby.sh
```
Note: having rbenv installe is critical if you intend on running multiple rails apps locally without having to run then inside Docker or convox containers.

4. Install node and nvm. 
```
scripts/installs/install-nvm.sh
```
Note: having nvm installe is critical if you intend on running multiple node apps locally without having to run then inside Docker or convox containers.

5. Install apache, php, phpmyadmin and SSL certificates. 
```
scripts/installs/install-apache.sh
```
6. Install docker and docker-compose. We run mysql and Redis inside a docker container.
scripts/installs/install-docker.sh

7. (Optional) Install convox and kubernetes
```
scripts/installs/install-kubernetes.sh
scripts/installs/install-convox-dev-rack.sh
```

