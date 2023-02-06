class OpServers < OpBase
  HOSTNAMES = {
    stepbet_dev: 'dev.stepbet.com', # 'ec2-35-161-73-241.us-west-2.compute.amazonaws.com',
    dietbet_dev: 'dev.dietbet.com', # 'ec2-35-161-73-241.us-west-2.compute.amazonaws.com',
    dietbet_imageserver_dev: 'images.dev.dietbet.com', # 'ec2-35-161-73-241.us-west-2.compute.amazonaws.com',
    stepbet_imageserver_dev: 'images.dev.stepbet.com', # 'ec2-35-161-73-241.us-west-2.compute.amazonaws.com',

    stepbet_imageserver_prod: 'images.stepbet.com', # "ec2-34-215-123-68.us-west-2.compute.amazonaws.com"
    dietbet_imageserver_prod: 'images.dietbet.com',

    dietbet_prod_1: 'ec2-34-217-21-240.us-west-2.compute.amazonaws.com',
    dietbet_prod_2: 'ec2-34-220-15-62.us-west-2.compute.amazonaws.com',
    dietbet_prod_3: 'ec2-54-184-246-120.us-west-2.compute.amazonaws.com',
    dietbet_prod_4: 'ec2-35-89-185-152.us-west-2.compute.amazonaws.com',

    stepbet_prod_1: 'ec2-34-219-250-250.us-west-2.compute.amazonaws.com',
    stepbet_prod_2: 'ec2-54-187-75-231.us-west-2.compute.amazonaws.com',
    stepbet_prod_3: 'ec2-54-189-81-66.us-west-2.compute.amazonaws.com',

    convox_office_external: '188.244.27.49',
    convox_office: '192.168.100.28'
  }
  SERVERS = {
    stepbet_dev: {
      user: 'centos',
      key: '~/Work/docs/secrets/keys/stepbet-stage-keys/staging.pem',
      hostnames: [:stepbet_dev],
      src: '/var/www/stepbet-dev',
      dst: '/var/www/dev.stepbet'
    },
    dietbet_dev: {
      user: 'centos',
      key: '~/Work/docs/secrets/keys/stepbet-stage-keys/staging.pem',
      hostnames: [:dietbet_dev],
      src: '/var/www/dietbet-dev',
      dst: '/var/www/dev.dietbet'
    },
    dietbet_imageserver_dev: {
      user: 'centos',
      key: '~/Work/docs/secrets/keys/stepbet-stage-keys/staging.pem',
      hostnames: [:dietbet_imageserver_dev],
      src: '/var/www/dietbet-imageserver',
      dst: '/var/www/dev.images.dietbet'
    },

    stepbet_prod: {
      user: 'centos',
      key: '~/Work/docs/secrets/keys/stepbet-prod-aws-php7/stepbet-prod-2019.pem',
      hostnames: %i[stepbet_prod_1 stepbet_prod_2 stepbet_prod_3],
      src: '/var/www/stepbet-prod',
      dst: '/srv/stepbet/current',
      deploy_path: '/srv/stepbet/deploy'
    },

    dietbet_prod: {
      user: 'centos',
      key: '~/Work/docs/secrets/keys/dietbet-prod-aws-php7/dietbet-prod-2019.pem',
      hostnames: %i[dietbet_prod_1 dietbet_prod_2 dietbet_prod_3 dietbet_prod_4],
      src: '/var/www/dietbet-prod',
      dst: '/srv/dietbet/current',
      deploy_path: '/srv/dietbet/deploy'
    },
    dietbet_imageserver_prod: {
      user: 'centos',
      key: '~/Work/docs/secrets/keys/dietbet-prod-aws-php7/dietbet-prod-2019.pem',
      hostnames: [:dietbet_imageserver_prod],
      src: '/var/www/dietbet-imageserver',
      dst: '/srv/dietbet/current'
    },
    stepbet_imageserver_prod: {
      user: 'centos',
      key: '~/Work/docs/secrets/keys/stepbet-prod-aws-php7/stepbet-prod-2019.pem',
      hostnames: [:stepbet_imageserver_prod],
      src: '/var/www/stepbet-imageserver',
      dst: '/srv/stepbet/current'
    },

    convox_office_external: {
      user: 'dev',
      key: '~/Work/docs/secrets/keys/ubuntu-work-ssh.pem',
      hostnames: [:convox_office_external],
      port: 3022
    },
    convox_office: {
      user: 'dev',
      key: '~/Work/docs/secrets/keys/ubuntu-work-ssh.pem',
      hostnames: [:convox_office]
    }
  }
end
