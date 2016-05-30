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
          packages => ['letsencrypt','python-letsencrypt','python-acme','python-cryptography'],
          priority => 500,
          release  => "${::lsbdistcodename}-backports",
        }

        Exec['apt_update'] -> Package['letsencrypt']

        package { 'letsencrypt':
          ensure => installed,
        }
      }
      default: {
          fail("Unsupported release: ${::lsbdistcodename}")
      }
    }
}
