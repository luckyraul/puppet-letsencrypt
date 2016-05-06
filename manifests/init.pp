# == Class: letsencrypt
# === Parameters
#
# [*ensure*]
#   Specify which version of Nginx packages to install, defaults to 'present'.
#   Please note that 'absent' to remove packages is not supported!
#
class letsencrypt
(
  $email   = undef,
  $ensure  = $letsencrypt::params::ensure,
  $install = $letsencrypt::params::install,
  $cron    = $letsencrypt::params::cron,
  $domains = {},
) inherits letsencrypt::params
{

  validate_string($email)

  if $install {
      class { 'letsencrypt::install': } -> Anchor['letsencrypt::begin']
  }

  if $cron {
      Class['letsencrypt::config'] -> class { 'letsencrypt::cron': } -> Anchor['letsencrypt::end']
  }

  anchor { 'letsencrypt::begin':} -> class { 'letsencrypt::config': } -> anchor { 'letsencrypt::end': }

}
