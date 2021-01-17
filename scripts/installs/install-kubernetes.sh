#!/bin/bash


# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command failed with exit code $?."' EXIT


cd

echo "Installing kubernetes"
echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
sleep 10s

sudo snap install microk8s --classic --channel=1.13/stable
echo "Enabling DNS on Kubernetes. Sleeping for 10 seconds. Click ctrl+C to abort script." 
sleep 10s
microk8s.enable dns storage
echo "Sleeping for another 60 seconds. Click ctrl+C to abort script." 
sleep 60s

export PATH="${PATH}:/snap/bin"
PATH="${PATH}:/snap/bin"

microk8s.status --wait-ready
mkdir -p ~/.kube
microk8s.config > ~/.kube/config
sudo snap restart microk8s
sudo snap alias microk8s.kubectl kubectl
kubectl config view
