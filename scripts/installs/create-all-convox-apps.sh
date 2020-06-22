#!/bin/bash


# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT


if test -d "${HOME}/Work/wb-services/falkor-game-service"; then
	if ! [[ $(convox apps) =~ 'falkor-game-service' ]]; then
		echo "Creating falkor-game-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/falkor-game-service
		convox apps create falkor-game-service
	else
	  echo 'falkor-game-service app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-membership-service"; then
	if ! [[ $(convox apps) =~ 'wb-membership-service' ]]; then
		echo "Creating wb-membership-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/wb-membership-service
		convox apps create wb-membership-service
	else
	  echo 'wb-membership-service app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-user-service"; then
	if ! [[ $(convox apps) =~ 'wb-user-service' ]]; then
		echo "Creating wb-user-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/wb-user-service
		convox apps create wb-user-service
	else
	  echo 'wb-user-service app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-auth-service"; then
	if ! [[ $(convox apps) =~ 'wb-auth-service' ]]; then
		echo "Creating wb-auth-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/wb-auth-service
		convox apps create wb-auth-service
	else
	  echo 'wb-auth-service app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-admin-auth-service"; then
	if ! [[ $(convox apps) =~ 'wb-admin-auth-service' ]]; then
		echo "Creating wb-admin-auth-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/wb-admin-auth-service
		convox apps create wb-admin-auth-service
	else
	  echo 'wb-admin-auth-service app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-billing-service"; then
	if ! [[ $(convox apps) =~ 'wb-billing-service' ]]; then
		echo "Creating wb-billing-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/wb-billing-service
		convox apps create wb-billing-service
	else
	  echo 'wb-billing-service app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-notify-service"; then
	if ! [[ $(convox apps) =~ 'wb-notify-service' ]]; then
		echo "Creating wb-notify-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/wb-notify-service
		convox apps create wb-notify-service
	else
	  echo 'wb-notify-service app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-social-service"; then
	if ! [[ $(convox apps) =~ 'wb-social-service' ]]; then
		echo "Creating wb-social-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/wb-social-service
		convox apps create wb-social-service
	else
	  echo 'wb-social-service app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-metric-service"; then
	if ! [[ $(convox apps) =~ 'wb-metric-service' ]]; then
		echo "Creating wb-metric-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/wb-metric-service
		convox apps create wb-metric-service
	else
	  echo 'wb-metric-service app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-admin-web"; then
	if ! [[ $(convox apps) =~ 'wb-admin-web' ]]; then
		echo "Creating wb-admin-web app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/wb-admin-web
		convox apps create wb-admin-web
	else
	  echo 'wb-admin-web app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-graphql-service"; then
	if ! [[ $(convox apps) =~ 'wb-graphql-service' ]]; then
		echo "Creating wb-graphql-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/wb-graphql-service
		convox apps create wb-graphql-service
	else
	  echo 'wb-graphql-service app already exists. Skipping.'
	fi
fi


if test -d "${HOME}/Work/wb-services/runbet-game-service"; then
	if ! [[ $(convox apps) =~ 'runbet-game-service' ]]; then
		echo "Creating runbet-game-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/runbet-game-service
		convox apps create runbet-game-service
	else
	  echo 'runbet-game-service app already exists. Skipping.'
	fi
fi


if test -d "${HOME}/Work/wb-services/wb-hub"; then
	if ! [[ $(convox apps) =~ 'wb-hub' ]]; then
		echo "Creating wb-hub app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/wb-hub
		convox apps create wb-hub
	else
	  echo 'wb-hub app already exists. Skipping.'
	fi
fi


if test -d "${HOME}/Work/wb-services/dietbet-game-service"; then
	if ! [[ $(convox apps) =~ 'dietbet-game-service' ]]; then
		echo "Creating dietbet-game-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/dietbet-game-service
		convox apps create dietbet-game-service
	else
	  echo 'dietbet-game-service app already exists. Skipping.'
	fi
fi


if test -d "${HOME}/Work/wb-services/stepbet-game-service"; then
	if ! [[ $(convox apps) =~ 'stepbet-game-service' ]]; then
		echo "Creating stepbet-game-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/stepbet-game-service
		convox apps create stepbet-game-service
	else
	  echo 'stepbet-game-service app already exists. Skipping.'
	fi
fi


if test -d "${HOME}/Work/wb-services/stepbet"; then
	if ! [[ $(convox apps) =~ 'stepbet' ]]; then
		echo "Creating stepbet app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/stepbet
		convox apps create stepbet
	else
	  echo 'stepbet app already exists. Skipping.'
	fi
fi


if test -d "${HOME}/Work/wb-services/dietbet"; then
	if ! [[ $(convox apps) =~ 'dietbet' ]]; then
		echo "Creating dietbet app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/dietbet
		convox apps create dietbet
	else
	  echo 'dietbet app already exists. Skipping.'
	fi
fi
