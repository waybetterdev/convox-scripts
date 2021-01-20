
class OpServers < OpBase
  HOSTNAMES = {
    stepbet_dev:  'dev.stepbet.com', # 'ec2-35-161-73-241.us-west-2.compute.amazonaws.com',
    dietbet_dev:  'dev.dietbet.com', # 'ec2-35-161-73-241.us-west-2.compute.amazonaws.com',
    dietbet_imageserver_dev: 'images.dev.dietbet.com', #'ec2-35-161-73-241.us-west-2.compute.amazonaws.com',
    stepbet_imageserver_dev:  'images.dev.stepbet.com', # 'ec2-35-161-73-241.us-west-2.compute.amazonaws.com',
    convox_office_external:  '188.244.27.49',
    convox_office:  '192.168.100.28',
  }
  SERVERS = {
    stepbet_dev:  {
      user:  'centos', 
      key:  '~/Work/deploy/keys/staging/staging.pem',
      hostnames:  [:stepbet_dev],
      src:  '/var/www/stepbet-dev', 
      dst:  '/var/www/dev.stepbet',
    },
    stepbet_imageserver_dev:  {
      user:  'centos', 
      key:  '~/Work/deploy/keys/staging/staging.pem',
      hostnames:  [:stepbet_imageserver_dev],
      src:  '/var/www/stepbet-imageserver-dev', 
      dst:  '/var/www/dev.images.stepbet',
    },
    dietbet_dev:  {
      user:  'centos', 
      key:  '~/Work/deploy/keys/staging/staging.pem',
      hostnames:  [:dietbet_dev],
      src:  '/var/www/dietbet-dev', 
      dst:  '/var/www/dev.dietbet',
    },
    dietbet_imageserver_dev:  {
      user:  'centos', 
      key:  '~/Work/deploy/keys/staging/staging.pem',
      hostnames:  [:dietbet_imageserver_dev],
      src:  '/var/www/dietbet-imageserver-dev', 
      dst:  '/var/www/dev.images.dietbet',
    },
    convox_office_external:  {
      user:  'dev', 
      key:  '/home/dev/Work/docs/secrets/keys/ubuntu-work-ssh.pem',
      hostnames:  [:convox_office_external],
      port: 3022
    },
    convox_office:  {
      user:  'dev', 
      key:  '/home/dev/Work/docs/secrets/keys/ubuntu-work-ssh.pem',
      hostnames:  [:convox_office]
    },
  }
end