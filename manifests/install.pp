# == Class: letsencrypt::install
class letsencrypt::install {

  case $::lsbdistcodename {
      'wheezy': {

      }
      'jessie': {
        include apt
        include apt::backports

        apt::pin { 'backports_letsencrypt':
          ensure   => 'present',
          packages => ['certbot','python-certbot'],
          priority => 500,
          release  => "${::lsbdistcodename}-backports",
        }

        Exec['apt_update'] -> Package['letsencrypt']

        package { 'certbot':
          ensure => installed,
        }
      }
      default: {
          fail("Unsupported release: ${::lsbdistcodename}")
      }
    }
}
