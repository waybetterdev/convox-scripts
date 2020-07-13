
class OpServers < OpBase
  HOSTNAMES = {
    stepbet_dev:  'dev.stepbet.com', # 'ec2-35-161-73-241.us-west-2.compute.amazonaws.com',
    dietbet_dev:  'dev.dietbet.com', # 'ec2-35-161-73-241.us-west-2.compute.amazonaws.com',
    dietbet_imageserver_dev: 'images.dev.dietbet.com', #'ec2-35-161-73-241.us-west-2.compute.amazonaws.com',
    stepbet_imageserver_dev:  'images.dev.stepbet.com', # 'ec2-35-161-73-241.us-west-2.compute.amazonaws.com',
  }
  SERVERS = {
    stepbet_dev:  {
      user:  'centos', 
      key:  '~/Work/deploy/keys/staging/staging.pem',
      hostnames:  [:stepbet_dev],
      src:  '/var/www/stepbet_dev', 
      dst:  '/var/www/dev.stepbet',
    },
    stepbet_imageserver_dev:  {
      user:  'centos', 
      key:  '~/Work/deploy/keys/staging/staging.pem',
      hostnames:  [:stepbet_imageserver_dev],
      src:  '/var/www/stepbet_imageserver_dev', 
      dst:  '/var/www/dev.images.stepbet',
    },
    dietbet_dev:  {
      user:  'centos', 
      key:  '~/Work/deploy/keys/staging/staging.pem',
      hostnames:  [:dietbet_dev],
      src:  '/var/www/dietbet_dev', 
      dst:  '/var/www/dev.dietbet',
    },
    dietbet_imageserver_dev:  {
      user:  'centos', 
      key:  '~/Work/deploy/keys/staging/staging.pem',
      hostnames:  [:dietbet_imageserver_dev],
      src:  '/var/www/dietbet_imageserver_dev', 
      dst:  '/var/www/dev.images.dietbet',
    },
  }
end