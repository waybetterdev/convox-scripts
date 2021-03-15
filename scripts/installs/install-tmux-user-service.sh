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

  mkdir "~/.config"
  mkdir "~/.config/systemd"
  mkdir "~/.config/systemd/user"
else
  echo 'User service already installed. Skipping.'
fi
