
class NpServices < OpBase


  CERTIFICATES = {
    'apache-local-selfsigned' => '.convox.local',
    'apache-office-selfsigned' => '.convox.office',
    'apache-waybetterdev-selfsigned' => '.waybetterdev.com',
    'apache-ninja-selfsigned' => '.waybetter.ninja',
    'apache-dietbet-selfsigned' => 'local.dietbet.com', 
  }

  SERVER_IPS = {
    localhost:                '127.0.0.1',
    convox_office_external:   '188.244.27.49',
    convox_office_internal:   '192.168.100.28',
  }

  CONFIG_TYPE_COVOX_OFFICE = 'config-convox-office'
  CONFIG_TYPE_DEV_PC = 'config-dev-pc'
  CONFING_TYPE = CONFIG_TYPE_DEV_PC

  NP_SERVICES = {
    local_kraken: [
      { name: 'wb-graphql-service',     gitname: 'wb-graphql',           type: 'node',        port: 3003 },
      { name: 'wb-admin-web',           gitname: 'wb-admin-web',         type: 'node',        port: 8010 },
    ],
    local_convox: [

    ],
    remote_convox_office: [
      { name: 'wb-admin-auth-service',  gitname: 'wb-admin-auth-service',  type: 'node' },
      { name: 'wb-notify-service',      gitname: 'wb-notify-service',      type: 'ruby' },
      { name: 'dietbet-game-service',   gitname: 'dietbet-game-service',   type: 'ruby' },
      { name: 'falkor-game-service',    gitname: 'falkor-game-service',    type: 'ruby' },
      { name: 'quitbet-game-service',   gitname: 'quitbet-game-service',   type: 'ruby' },
      { name: 'runbet-game-service',    gitname: 'runbet-game-service',    type: 'ruby' },
      { name: 'stepbet-game-service',   gitname: 'stepbet-game-service',   type: 'ruby' },
      { name: 'wb-auth-service',        gitname: 'wb-auth-service',        type: 'node' },
      { name: 'wb-billing-service',     gitname: 'wb-billing-service',     type: 'ruby' },
      { name: 'wb-membership-service',  gitname: 'wb-membership-service',  type: 'ruby' },
      { name: 'wb-metric-service',      gitname: 'wb-metric-service',      type: 'ruby' },
      { name: 'wb-hub',                 gitname: 'wb-hub',                 type: 'node' },
      { name: 'wb-social-service',      gitname: 'wb-social-service',      type: 'ruby',       port: 3005 },
      { name: 'wb-user-service',        gitname: 'wb-user-service',        type: 'node',       port: 4000 },
    ]
  }

end
