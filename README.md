# Convox Scripts

This repository initially started as a tool for linking NP microservices between them but then ended up containing everthing we use for local development and deployment.

## Contents
1. Scripts for installing all the necesarry programs and utilities (based on Ubuntu LTS 20.04 packages). You can find them in `/scripts/installs` 
2. Scripts for deploying to OP services [Docs](/doc/op-scripts.md)
3. Scripts for setting up your linux user bash aliases and profiles. You can find them in  `/configs/linux-user/bash/` [TODO Add Docs](/)
4. Scripts for starting and configuring NP service. [TODO Add Docs](/)
5. Scripts for running an apache server as a proxy for linking NP and OP services in between then and having HTTPS work via self signed certificates that you can find in `/certs/apache`.
6. Configuration templates needed when creating a new development environment. You can find these in `/configs/templates/` 


## OP Scripts and their usage
1. [opdeploy](/doc/op-scripts.md#op-deploy) - deployment script for deploying on either of the three servers `api.stepbet.com`, `images.stepbet.com`, `dev.stepbet.com`  

2. [opkonnect](/doc/op-scripts.md#op-konnect) - opens an SSH connection to a server

3. [oplogs](/doc/op-scripts.md#op-logs) - downloads file logs from servers


## NP scripts and their usage
TODO: add docs here
1. `npsconfig`
2. `npsenv`
3. `npsinstall`
4. `npsrun`


## Installation
**Note:** Our local development envoronment is Ubuntu LTS 20.04 so all installation scripts are based on it. If you have an Ubuntu or other compatible Debian based ditros, you can use our install scripts. Or otherwise your will need to open the install scripts and run the installation commands that are specific to your Linux.

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
