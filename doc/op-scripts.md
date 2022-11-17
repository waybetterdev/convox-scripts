# OP Scripts and their usage

# Set Up
Before being able to run the OP scripts, you need to make sure you have the following files in place:
1. Your `local-settings/op-servers-config.rb` config file must contain SB servers `stepbet_prod` and `stepbet_dev`
We run the following config on them:
```
  stepbet_dev: {
    user: 'centos',
    key: '~/Work/docs/secrets/keys/stepbet-stage-keys/staging.pem',
    hostnames: [:stepbet_dev],
    src: '/var/www/stepbet-dev',
    dst: '/var/www/dev.stepbet'
  },
  stepbet_prod: {
    user: 'centos',
    key: '~/Work/docs/secrets/keys/stepbet-prod-aws-php7/stepbet-prod-2019.pem',
    hostnames: %i[stepbet_prod_1 stepbet_prod_2],
    src: '/var/www/stepbet-prod',
    dst: '/srv/stepbet/current',
    backup_path: '/srv/stepbet'
  },
  stepbet_imageserver_prod: {
    user: 'centos',
    key: '~/Work/docs/secrets/keys/stepbet-prod-aws-php7/stepbet-prod-2019.pem',
    hostnames: [:stepbet_imageserver_prod],
    src: '/var/www/stepbet-imageserver',
    dst: '/srv/stepbet/current'
  },
```
2. Make sure your SSH private keys are in place. Note: private keys are not included in this repo. You will need to get them separetely.
```
~/Work/docs/secrets/keys/stepbet-stage-keys/staging.pem
~/Work/docs/secrets/keys/stepbet-prod-aws-php7/stepbet-prod-2019.pem
~/Work/docs/secrets/keys/stepbet-prod-aws-php7/stepbet-prod-2019.pem
```
3. Make sure you have the required ruby version and ruby gems for the scrips. Check our install docs for how to install ruby.




# OP Deploy
Builds a zip file from `/var/www/stepbet_prod` or `/var/www/stepbet_dev` and deploys it on either PROD or DEV Stepbet servers.

Usage:
1. Switch your `/var/www/stepbet_prod` repository to `master` and find the hash for the last deployed commit to production. E.g. `137474ce2fcadaa88ece528a5d3122059ad13557`
2. Run the deploy script
```
opdeploy -a stepbet-prod -c 137474ce2fcadaa88ece528a5d3122059ad13557
```
The script will print the files about to be deployed and will ask you to confirm 
```
You are about to deploy to stepbet-dev
Files modified:
game-service/api/user/GetUserNotifications.php
game-service/system/controllers/includes/game.inc.php
system/controllers/admin/test.php
system/cron/daily-game-cron.php
system/data/constants.php
system/models/SiteCache.class.php
system/models/User.class.php
system/models/UserNotification.class.php
system/tools/game-cron-tasks.php

Continue? y/n

```
After that it will confirm that the files were extracted on the servers
```
Connection to dev.stepbet.com closed.
Archive:  /var/www/dev.stepbet/stepbet-dev.zip
  inflating: /var/www/dev.stepbet/game-service/api/user/GetUserNotifications.php  
  inflating: /var/www/dev.stepbet/game-service/system/controllers/includes/game.inc.php  
  inflating: /var/www/dev.stepbet/system/controllers/admin/test.php  
  inflating: /var/www/dev.stepbet/system/tools/game-cron-tasks.php  
  inflating: /var/www/dev.stepbet/system/data/constants.php  
  inflating: /var/www/dev.stepbet/system/cron/daily-game-cron.php  
  inflating: /var/www/dev.stepbet/system/models/SiteCache.class.php  
  inflating: /var/www/dev.stepbet/system/models/UserNotification.class.php  
  inflating: /var/www/dev.stepbet/system/models/User.class.php  
Connecting to centos@dev.stepbet.com

```

# OP Konnect
Connects via SSH to OP servers. Use it if you don't like entering private key and dommain into the SSH command each time.

Usage:
Enter a server name from `local-settings/op-servers-config.rb`. We use `stepbet-prod-1` and `stepbet-prod-2` to differentiate between the two Fron End Servers.
```
opkonnect -s stepbet-prod-1
```

# OP Logs
Downloads, joins and opens text logs from our servers.

Usage:
Run `oplogs --help` to get the full list of options.
```
  A deploy script for old platform websites
  Ex:
    opdeploy -a stepbet-dev

Specific options:
    -z, --debug                      Optional: load pry
    -a, --app=A                      Application Name (website name)
    -f, --file=F                     Log file to download
    -o, --open                       Optional, open the downloaded files on exit
    -j, --join                       Optional, join multiple files in one file
    -h, --help                       Prints this help
```
We usually use all of them. The following command downloads database error logs fron the Fron End servers and opens them in text editor
```
oplogs -a stepbet-prod -j -o -f database/db-errors.txt
```

If you close it by accident, the script prints out the paths of the downloaded files so that you don't need to download it again
```
Copying '/srv/stepbet/current/system/logs/database/db-errors.txt' to '/home/mihai/Work/deploy/logs/stepbet-prod/FT-1-db-errors.txt' from 'centos@ec2-34-219-250-250.us-west-2.compute.amazonaws.com'
Copying '/srv/stepbet/current/system/logs/database/db-errors.txt' to '/home/mihai/Work/deploy/logs/stepbet-prod/FT-2-db-errors.txt' from 'centos@ec2-54-187-75-231.us-west-2.compute.amazonaws.com'

```


# OP PhpLogs
Unlike `oplogs`, it does not connect and download logs. It opens php error logs in `VIM` via `SSH`. We use this for clearing the error logs so that error notification emails don't include old errors.

Usage: 
```
opphplogs -s stepbet-prod-1
```






