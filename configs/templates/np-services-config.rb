
class NpServices < OpBase


  CERTIFICATES = {
    'apache-local-selfsigned' => '.convox.local',
    'apache-waybetterdev-selfsigned' => '.waybetterdev.com',
    'apache-ninja-selfsigned' => '.waybetter.ninja',
    'apache-dietbet-selfsigned' => 'local.dietbet.com', 
  }

  # avaiolable locations: kraken, convox-local, convox-office,
  SERVICES = [
    # local services from kraken
    { name: 'wb-user-service',        gitname: 'wb-user-service',      location: 'kraken', type: 'node',       port: 4000 },
    { name: 'wb-graphql-service',     gitname: 'wb-graphql',           location: 'kraken', type: 'node',        port: 3003 },
    { name: 'wb-admin-web',           gitname: 'wb-admin-web',         location: 'kraken', type: 'node',        port: 8010 },

    # services on local convox rack
    #{ name: 'wb-social-service',      gitname: 'wb-social-service',    location: 'convox-local',   type: 'ruby'  },
    
    # services on office convox rack
    { name: 'wb-admin-auth-service',  gitname: 'wb-admin-auth-service',  location: 'convox-office', type: 'node' },
    { name: 'wb-notify-service',      gitname: 'wb-notify-service',      location: 'convox-office', type: 'ruby' },
    { name: 'dietbet-game-service',   gitname: 'dietbet-game-service',   location: 'convox-office', type: 'ruby' },
    { name: 'falkor-game-service',    gitname: 'falkor-game-service',    location: 'convox-office', type: 'ruby' },
    { name: 'quitbet-game-service',   gitname: 'quitbet-game-service',   location: 'convox-office', type: 'ruby' },
    { name: 'runbet-game-service',    gitname: 'runbet-game-service',    location: 'convox-office', type: 'ruby' },
    { name: 'stepbet-game-service',   gitname: 'stepbet-game-service',   location: 'convox-office', type: 'ruby' },
    { name: 'wb-auth-service',        gitname: 'wb-auth-service',        location: 'convox-office', type: 'node' },
    { name: 'wb-billing-service',     gitname: 'wb-billing-service',     location: 'convox-office', type: 'ruby' },
    { name: 'wb-membership-service',  gitname: 'wb-membership-service',  location: 'convox-office', type: 'ruby' },
    { name: 'wb-metric-service',      gitname: 'wb-metric-service',      location: 'convox-office', type: 'ruby' },
    { name: 'wb-hub',                 gitname: 'wb-hub',                 location: 'convox-office', type: 'node' },
    { name: 'wb-social-service',      gitname: 'wb-social-service',      location: 'convox-office', type: 'ruby' },
  ]


end
