
#!/bin/bash



# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command failed with exit code $?."' EXIT


cd

sudo apt-get install -y git tmux vim htop openssh-server


#if ! [ -x "$(command -v github-desktop)" ]; then
	#echo "Installing github-desktop"
	#echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	#sleep 10s

	#wget -qO - https://packagecloud.io/shiftkey/desktop/gpgkey | sudo tee /etc/apt/trusted.gpg.d/shiftkey-desktop.asc > /dev/null
	#sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/shiftkey/desktop/any/ any main" > /etc/apt/sources.list.d/packagecloud-shiftky-desktop.list'
	#sudo apt-get update

	#sudo apt install github-desktop

#else
#  echo 'github-desktop is already installed. Skipping.'
#fi


sudo snap install code --classic
snap install sublime-text --classic
