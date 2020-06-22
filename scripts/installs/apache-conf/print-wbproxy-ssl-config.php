<?php

error_reporting(E_ERROR | E_WARNING | E_PARSE);



##################################
####      HTTPS CONFIG        #### 
##################################

$httpsServices = array(
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

$httpServices = array(
  'phpmyadmin.convox.local'            => array('path' => '/var/www/phpmyadmin'),
);



# color definition
$white = "\033[39m";
$red = "\033[31m";
$green = "\033[32m";


echo "\n";
echo "HTTP CONFIG\n";

$file = fopen('wb-proxy-ssl.conf', 'w');
$config = '';
foreach ($httpsServices as $domain => $conf)
{
  $service = $conf['service'];
  $documentRoot = $conf['path'];
  $cert = $conf['cert'];
  $strDirectory = '';
  
  $proxySettings = array();
  if ($service)
  {
    $proxySettings = array(
      'ProxyPass' => '/ ' . $service,
      'ProxyPassReverse' => '/ ' . $service
    );
    
    $documentRoot = '/var/www/wb-proxy';
    $proxySettings['SSLProxyEngine'] = 'On';
    $proxySettings['SSLProxyCheckPeerCN'] = 'On';
    $proxySettings['SSLProxyCheckPeerExpire'] = 'On';

    if (preg_match('/^http:/', $service))
    {
      $proxySettings['SSLProxyEngine'] = 'Off';
      $proxySettings['SSLProxyVerify'] = 'none';
      $proxySettings['SSLProxyCheckPeerCN'] = 'Off';
      $proxySettings['SSLProxyCheckPeerExpire'] = 'Off';
    }
    echo "    {$red}https://$domain {$white}redirects to {$green}$service\n"; 
  }
  else
  {
    $strDirectory =  ' 
    <Directory "' . $documentRoot . '">
      Options Indexes FollowSymLinks Includes
      Order deny,allow
      Deny from all
      Allow from all
      AllowOverride All
    </Directory>
';
    print "    {$red}https://$domain {$white}executes path {$green}$documentRoot\n";
  }
  
  $conf = array(
    'ServerAdmin' => 'mihai@waybetter.com',
    'ServerName' => $domain,
    'DocumentRoot' => $documentRoot,
    'ErrorLog' => '/var/www/wb-proxy/logs/https-' . $domain . '.error.log',
    'CustomLog' => '/var/www/wb-proxy/logs/https-' . $domain . '.access.log combined',
    'SSLEngine' => 'on',
    'SSLCertificateFile' => '/etc/ssl/certs/' . $cert . '.crt',
    'SSLCertificateKeyFile' => '/etc/ssl/private/' . $cert . '.key',
  );
  $conf = array_replace_recursive($conf, $proxySettings);


  
  $lines = array();
  foreach ($conf as $key => $value)
    $lines[] = $key . ' ' . $value;
  

  $config = '
#' . $domain . '
<IfModule mod_ssl.c>
  <VirtualHost _default_:443>
    ' . implode("\n    ", $lines) . '

    <FilesMatch "\.(cgi|shtml|phtml|php)$">
                    SSLOptions +StdEnvVars
    </FilesMatch>
    <Directory /usr/lib/cgi-bin>
                    SSLOptions +StdEnvVars
    </Directory>
    ' . $strDirectory . '
  </VirtualHost>
</IfModule>

';
  fputs($file, $config);
}

fclose($file);
echo "{$white}Saved wb-proxy-ssl.conf \n";



echo "\n";
echo "HTTP CONFIG\n";

$file = fopen('wb-proxy.conf', 'w');
$config = '';
foreach ($httpServices as $domain => $conf)
{
  $service = $conf['service'];
  $documentRoot = $conf['path'];
  $cert = $conf['cert'];
  $strDirectory = '';
  
  $proxySettings = array();
  if ($service)
  {
    $proxySettings = array(
      'ProxyPass' => '/ ' . $service,
      'ProxyPassReverse' => '/ ' . $service
    );
    
    $documentRoot = '/var/www/wb-proxy';
    $proxySettings['SSLProxyEngine'] = 'On';
    $proxySettings['SSLProxyCheckPeerCN'] = 'On';
    $proxySettings['SSLProxyCheckPeerExpire'] = 'On';

    if (preg_match('/^http:/', $service))
    {
      $proxySettings['SSLProxyEngine'] = 'Off';
      $proxySettings['SSLProxyVerify'] = 'none';
      $proxySettings['SSLProxyCheckPeerCN'] = 'Off';
      $proxySettings['SSLProxyCheckPeerExpire'] = 'Off';
    }
    echo "    {$red}http://$domain {$white}redirects to {$green}$service\n"; 
  }
  else
  {
    $strDirectory =  ' 
    <Directory "' . $documentRoot . '">
      Options Indexes FollowSymLinks Includes
      Order deny,allow
      Deny from all
      Allow from all
      AllowOverride All
    </Directory>
';
    print "    {$red}http://$domain {$white}executes path {$green}$documentRoot\n";
  }
  
  $conf = array(
    'ServerAdmin' => 'mihai@waybetter.com',
    'ServerName' => $domain,
    'DocumentRoot' => $documentRoot,
    'ErrorLog' => '/var/www/wb-proxy/logs/https-' . $domain . '.error.log',
    'CustomLog' => '/var/www/wb-proxy/logs/https-' . $domain . '.access.log combined',
  );
  $conf = array_replace_recursive($conf, $proxySettings);


  
  $lines = array();
  foreach ($conf as $key => $value)
    $lines[] = $key . ' ' . $value;
  
  
  $config = '
#' . $domain . '
<IfModule mod_ssl.c>
  <VirtualHost _default_:80>
    ' . implode("\n    ", $lines) . '

    <FilesMatch "\.(cgi|shtml|phtml|php)$">
                    SSLOptions +StdEnvVars
    </FilesMatch>
    <Directory /usr/lib/cgi-bin>
                    SSLOptions +StdEnvVars
    </Directory>
    ' . $strDirectory . '
  </VirtualHost>
</IfModule>

';
  fputs($file, $config);
}

fclose($file);
print "{$white}Saved wb-proxy.conf \n";
