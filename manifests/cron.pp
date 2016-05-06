# == Class: letsencrypt::cron
class letsencrypt::cron {

  file {'/opt/letsencrypt_update.sh':
    ensure  => 'present',
    content => '#!/bin/sh
    for conf in $(ls /etc/letsencrypt/configs/*.ini); do
      letsencrypt --renew --config "$conf" certonly
    done'
  }

  cron { 'letsencrypt-renew':
    command => '/bin/sh /opt/letsencrypt_update.sh',
    user    => 'root'
    minute  => '11',
    hour    => '1',
    date    => '1',
    require => File['/opt/letsencrypt_update.sh'],
  }
}
