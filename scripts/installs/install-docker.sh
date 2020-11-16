#!/bin/bash



# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT


cd

echo "Installing Docker"
echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
sleep 10s

sudo apt install -y docker.io 
docker --version
sudo systemctl enable docker


sudo usermod -aG docker ${USER}

echo "Installing Docker"
sudo apt install -y docker-compose
