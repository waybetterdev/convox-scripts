#!/bin/bash



# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT



# TODO: why is the alias not working?
kk='/home/dev/Work/docs/scripts/ruby/kmd-local'

# TODO : why is this setting always off?
rbenv init
rbenv shell 2.6.2

sudo echo 'fixing iptables' && sudo iptables -P FORWARD ACCEPT && echo 'done'
convox registries add 247028141071.dkr.ecr.us-west-2.amazonaws.com AWS $(aws ecr get-login-password --region us-west-2 --profile prod)


if test -d "${HOME}/Work/wb-services/falkor-game-service"; then
	if ! [[ $(convox apps) =~ 'falkor-game-service' ]]; then
		echo "Creating falkor-game-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/falkor-game-service
		convox apps create falkor-game-service
		cd "${HOME}/Work/wb-services/falkor-game-service"
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local falkor
		$kk refresh-env -- local falkor no-confirm
		convox build
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

		cd "${HOME}/Work/wb-services/wb-membership-service"
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local membership
		$kk refresh-env -- local membership no-confirm
		convox build
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

		cd "${HOME}/Work/wb-services/wb-user-service"
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local user
		$kk refresh-env -- local user no-confirm
		convox build
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

		cd "${HOME}/Work/wb-services/wb-auth-service"
		git reset --hard
		git clean -f
		git pull

		$kk refresh-yml -- local auth
		$kk refresh-env -- local auth no-confirm
		convox build
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

		cd "${HOME}/Work/wb-services/wb-admin-auth-service"
		git reset --hard
		git clean -f
		git pull

		$kk refresh-yml -- local admin-auth
		$kk refresh-env -- local admin-auth no-confirm
		convox build
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
		cd  "${HOME}/Work/wb-services/wb-billing-service"
		git reset --hard
		git clean -f
		git pull

		$kk refresh-yml -- local billing
		$kk refresh-env -- local billing no-confirm
		convox build
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

		cd "${HOME}/Work/wb-services/wb-notify-service"
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local notify
		$kk refresh-env -- local notify no-confirm
		convox build
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

		cd "${HOME}/Work/wb-services/wb-social-service"
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local social
		$kk refresh-env -- local social no-confirm
		convox build
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
		cd "${HOME}/Work/wb-services/wb-metric-service"
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local metric
		$kk refresh-env -- local metric no-confirm
		convox build
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
		cd "${HOME}/Work/wb-services/wb-admin-web"
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local ninja
		$kk refresh-env -- local ninja no-confirm
		convox build
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
		cd "${HOME}/Work/wb-services/wb-graphql-service"
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local graphql
		$kk refresh-env -- local graphql no-confirm
		convox build
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

		cd "${HOME}/Work/wb-services/runbet-game-service"
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local runbet
		$kk refresh-env -- local runbet no-confirm
		convox build
	else
	  echo 'runbet-game-service app already exists. Skipping.'
	fi
fi


if test -d "${HOME}/Work/wb-services/quitbet-game-service"; then
	if ! [[ $(convox apps) =~ 'quitbet-game-service' ]]; then
		echo "Creating quitbet-game-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/quitbet-game-service
		convox apps create quitbet-game-service
		cd "${HOME}/Work/wb-services/quitbet-game-service"
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local quitbet
		$kk refresh-env -- local quitbet no-confirm
		convox build
	else
	  echo 'quitbet-game-service app already exists. Skipping.'
	fi
fi


if test -d "${HOME}/Work/wb-services/wb-hub"; then
	if ! [[ $(convox apps) =~ 'wb-hub' ]]; then
		echo "Creating wb-hub app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd ~/Work/wb-services/wb-hub
		convox apps create wb-hub
		cd "${HOME}/Work/wb-services/wb-hub"
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local hub
		$kk refresh-env -- local hub no-confirm
		convox build
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
		cd "${HOME}/Work/wb-services/dietbet-game-service"
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local dietbet-game-service
		$kk refresh-env -- local dietbet-game-service no-confirm
		convox build
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
		cd "${HOME}/Work/wb-services/stepbet-game-service"
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local stepbet-game-service
		$kk refresh-env -- local stepbet-game-service no-confirm
		convox build
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
		cd "${HOME}/Work/wb-services/stepbet"
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local stepbet
		$kk refresh-env -- local stepbet no-confirm
		convox build
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
		cd "${HOME}/Work/wb-services/dietbet"
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local dietbet 
		$kk refresh-env -- local dietbet no-confirm
		convox build
	else
	  echo 'dietbet app already exists. Skipping.'
	fi
fi
