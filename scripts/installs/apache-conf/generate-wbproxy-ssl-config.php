<?php

error_reporting(E_ERROR | E_WARNING | E_PARSE);


$path = pathinfo(__FILE__)["dirname"];
$docsPath = realpath("$path/../../../");

if (file_exists("$docsPath/local-settings/apache-sites.php"))
  require_once("$docsPath/local-settings/apache-sites.php");
else
  require_once("$docsPath/configs/templates/apache-sites.template.php");


$httpsOutConfigPath = "$docsPath/local-settings/wb-proxy-ssl.conf";
$httpOutConfigPath = "$docsPath/local-settings/wb-proxy.conf";

# color definition
$white = "\033[39m";
$red = "\033[31m";
$green = "\033[32m";


$allDomains = [];

echo "\n";
echo "HTTP CONFIG\n";

$file = fopen($httpsOutConfigPath, 'w');
$config = '';
foreach ($HTTPS_SERVICES as $domain => $conf)
{
  $service = $conf['service'];
  $allDomains[$domain] = $domain;
  
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
echo "{$white}Saved to file '$httpsOutConfigPath' \n";



echo "\n";
echo "HTTP CONFIG\n";

$file = fopen($httpOutConfigPath, 'w');
$config = '';
foreach ($HTTP_SERVICES as $domain => $conf)
{
  $service = $conf['service'];
  $allDomains[$domain] = $domain;

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
print "{$white}Saved to file '$httpOutConfigPath' \n";


echo "\n";
echo "\n";
echo "################## HOSTS FILE #######################";
foreach ($allDomains as $service)
{
  echo "127.0.0.1 $service \n";
}