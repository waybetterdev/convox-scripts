
class OpServers < OpBase
  HOSTNAMES = {
    stepbet_dev:  'ec2-54-202-14-77.us-west-2.compute.amazonaws.com',
    dietbet_dev:  'ec2-54-202-14-77.us-west-2.compute.amazonaws.com',
    dietbet_dev_new:  'ec2-35-161-73-241.us-west-2.compute.amazonaws.com',
  }
  SERVERS = {
    stepbet_dev:  {
      user:  'centos', 
      key:  '~/Work/deploy/keys/dietbet-dev-aws/dietbet-dev-aws.pem',
      hostnames:  [:stepbet_dev],
      src:  '/var/www/stepbet_dev', 
      dst:  '/var/www/dev.stepbet',
    },
    dietbet_dev:  {
      user:  'centos', 
      key:  '~/Work/deploy/keys/dietbet-dev-aws/dietbet-dev-aws.pem',
      hostnames:  [:dietbet_dev],
      src:  '/var/www/dietbet_dev', 
      dst:  '/var/www/dev.dietbet',
    },
    dietbet_dev_new:  {
      user:  'centos', 
      key:  '~/Work/deploy/keys/dietbet-prod-aws/dietbet-prod-2019.pem',
      hostnames:  [:dietbet_dev_new],
      src:  '/var/www/dietbet_dev', 
      dst:  '/var/www/dev.dietbet',
    },
  }
end