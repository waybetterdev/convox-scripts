
class OpServers < OpBase
  HOSTNAMES = {
    stepbet_dev_old:  'ec2-54-202-14-77.us-west-2.compute.amazonaws.com',
    dietbet_dev_old:  'ec2-54-202-14-77.us-west-2.compute.amazonaws.com',
    stepbet_dev:  'ec2-35-161-73-241.us-west-2.compute.amazonaws.com',
    dietbet_dev:  'ec2-35-161-73-241.us-west-2.compute.amazonaws.com',
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
  }
end