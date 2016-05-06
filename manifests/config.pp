# == Class: letsencrypt::config
class letsencrypt::config (
  $domains = $letsencrypt::domains,
)
{
  file {'/etc/letsencrypt/configs':
    ensure => directory,
  }

  create_resources('letsencrypt::config::domain', $domains)
}
