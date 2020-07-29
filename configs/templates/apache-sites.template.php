<?php


##################################
####      HTTPS CONFIG        #### 
##################################

$HTTPS_SERVICES = array(
  // external domains
  'wb-user-service.convox.local'       => array('service' => 'https://web.wb-user-service.convox/',      'cert' => 'apache-local-selfsigned'),
  'wb-admin-auth-service.convox.local' => array('service' => 'https://web.wb-admin-auth-service.convox/','cert' => 'apache-local-selfsigned'),
  'wb-auth-service.convox.local'       => array('service' => 'https://web.wb-auth-service.convox/',      'cert' => 'apache-local-selfsigned'),
  'wb-billing-service.convox.local'    => array('service' => 'https://web.wb-billing-service.convox/',   'cert' => 'apache-local-selfsigned'),
  'wb-metric-service.convox.local'     => array('service' => 'https://web.wb-metric-service.convox/',    'cert' => 'apache-local-selfsigned'),
  'wb-notify-service.convox.local'     => array('service' => 'https://web.wb-notify-service.convox/',    'cert' => 'apache-local-selfsigned'),
  'wb-admin-web.convox.local'          => array('service' => 'https://web.wb-admin-web.convox/',         'cert' => 'apache-local-selfsigned'),
  'wb-hub.convox.local'                => array('service' => 'https://web.wb-hub.convox/',               'cert' => 'apache-local-selfsigned'),
  'wb-social-service.convox.local'     => array('service' => 'https://web.wb-social-service.convox/',    'cert' => 'apache-local-selfsigned'),
  'runbet-game-service.convox.local'   => array('service' => 'https://web.runbet-game-service.convox/',  'cert' => 'apache-local-selfsigned'),
  'quitbet-game-service.convox.local'   => array('service' => 'https://web.quitbet-game-service.convox/', 'cert' => 'apache-local-selfsigned'),
  'falkor-game-service.convox.local'   => array('service' => 'https://web.falkor-game-service.convox/',  'cert' => 'apache-local-selfsigned'),
  'wb-graphql-service.convox.local'    => array('service' => 'https://web.wb-graphql-service.convox/',   'cert' => 'apache-local-selfsigned'),
  'dietbet-game-service.convox.local'  => array('service' => 'https://web.dietbet-game-service.convox/', 'cert' => 'apache-local-selfsigned'),
  'prod-stepbet.convox.local'          => array('path' => '/var/www/stepbet',                            'cert' => 'apache-local-selfsigned'),
  'dev-stepbet.convox.local'           => array('path' => '/var/www/stepbet',                            'cert' => 'apache-local-selfsigned'),
  'prod-dietbet.convox.local'          => array('path' => '/var/www/dietbet',                            'cert' => 'apache-local-selfsigned'),
  'dev-dietbet.convox.local'           => array('path' => '/var/www/dietbet',                            'cert' => 'apache-local-selfsigned'),
  'phpmyadmin.convox.local'            => array('path' => '/var/www/phpmyadmin',                         'cert' => 'apache-local-selfsigned'),
  
  'accounts-local.waybetterdev.com'  => array('service' => 'https://web.wb-auth-service.convox/',      'cert' => 'apache-waybetterdev-selfsigned'),
  'graphql-local.waybetterdev.com'   => array('service' => 'https://web.wb-graphql-service.convox/',   'cert' => 'apache-waybetterdev-selfsigned'),
  'graphql-local.waybetter.ninja'    => array('service' => 'https://web.wb-graphql-service.convox/',   'cert' => 'apache-ninja-selfsigned'),
  'www-local.waybetter.ninja'        => array('service' => 'https://web.wb-admin-web.convox/',         'cert' => 'apache-ninja-selfsigned'),
  'admin-auth-local.waybetter.ninja' => array('service' => 'https://web.wb-admin-auth-service.convox/', 'cert' => 'apache-ninja-selfsigned'),
   // note that the hub is on HTTP since it's not inside convox
  'hub-local.waybetterdev.com'       => array('service' => 'http://hub-local.waybetterdev.com:8000/', 'cert' => 'apache-waybetterdev-selfsigned'),
);


##################################
####      HTTP  CONFIG        #### 
##################################

$HTTP_SERVICES = array(
  'phpmyadmin.convox.local'            => array('path' => '/var/www/phpmyadmin'),
);
