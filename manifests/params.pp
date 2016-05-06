# == Class: letsencrypt::params
class letsencrypt::params {
  $ensure = present
  $cron  = true

  case $::operatingsystem {
      'Debian': {
        case $::lsbdistcodename {
            'wheezy': {

            }
            'jessie': {

            }
            default: {
                fail("Unsupported release: ${::lsbdistcodename}")
            }
          }

      }
      default: {
          fail("Unsupported release: ${::lsbdistcodename}")
      }
  }
}
