#!/bin/bash


# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command failed with exit code $?."' EXIT


if ! test -f "~/.config/systemd/user"; then
	echo "Creating ~/.config/systemd/user path"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script." 
	sleep 10s

  sudo apt-get install -y xfce4-terminal

  cd 
  mkdir -p ".config"
  mkdir -p ".config/systemd"
  mkdir -p ".config/systemd/user"

  cp -f ~/Work/docs/configs/linux-user/systemd/wbtmux.service .config/systemd/user/wbtmux.service

  systemctl --user enable wbtmux.service

  systemctl --user start wbtmux.service
else
  echo 'User service already installed. Skipping.'
fi
