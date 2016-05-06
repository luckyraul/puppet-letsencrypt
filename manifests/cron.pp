# == Class: letsencrypt::cron
class letsencrypt::cron {

  cron { 'letsencrypt-renew':
    command => 'letsencrypt renew',
    user    => 'root',
    minute  => '11',
    hour    => '1',
    date    => '1',
  }
}
