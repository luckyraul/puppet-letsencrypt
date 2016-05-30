# Define letsencrypt::config::domain
define letsencrypt::config::domain (
      $ensure = present,
      $domains = [],
      $webroot = '',
      $rsa_key_size = 4096,
      $email = $letsencrypt::email,
      $text = true,
      $agree_tos = 'True',
      $server = 'https://acme-v01.api.letsencrypt.org/directory',
      $authenticator = 'webroot',
  ) {


    file { "/etc/letsencrypt/configs/${name}.ini":
        ensure => $ensure,
    }

  $defaults = { 'path' => "/etc/letsencrypt/configs/${name}.ini", require => File["/etc/letsencrypt/configs/${name}.ini"] }
  $settings = { '' =>
    {
      'server'        => $server,
      'rsa-key-size'  => $rsa_key_size,
      'domains'       => $domains,
      'authenticator' => $authenticator,
      'email'         => $email,
      'text'          => $text,
      'webroot-path'  => $webroot,
      'agree-tos'     => $agree_tos,
    }
  }
  create_ini_settings($settings, $defaults)


  file {$webroot:
    'ensure' => directory,
  }

  exec { 'name':
    command => "certbot -c ${defaults['path']}",
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  }

}
