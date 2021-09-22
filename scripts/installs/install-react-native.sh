#!/bin/bash



# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command failed with exit code $?."' EXIT


cd

sudo apt-get install openjdk-8-jdk

echo "Please set default JDK to 8.0"
sudo update-alternatives --config java

if test -f "$ANDROID_HOME/tools/bin/sdkmanager"; then
	echo "Approving all android licenses"
	$ANDROID_HOME/tools/bin/sdkmanager --licenses
else
  echo 'Android Studio and SDK manager not installed'
fi

