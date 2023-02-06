#!/bin/bash

folder_path=/srv/stepbet/stepbet-$(date '+%Y%m%d-%I%M%S')
mkdir $folder_path

echo Copying Current Files.

cp -r /srv/stepbet/current/* $folder_path
# Copy hidden files from the source folder as well
cp /srv/stepbet/current/.* $folder_path

echo Copy Completed.

unzip -o /srv/stepbet/deploy/stepbet-prod.zip -d $folder_path
rm /srv/stepbet/deploy/stepbet-prod.zip

rm -f /srv/stepbet/prev
cp -P /srv/stepbet/current /srv/stepbet/prev

ln -sfn $folder_path /srv/stepbet/current

echo Deploy Completed.

#cp -L -r /srv/stepbet/current/* $folder_path

#rsync -av --no-o --no-g --copy-links /srv/stepbet/current/ $folder_path --exclude 'system/logs/'

