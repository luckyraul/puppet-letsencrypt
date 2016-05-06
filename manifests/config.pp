# == Class: letsencrypt::config
class letsencrypt::config (
  $domains = $letsencrypt::domains,
)
{
  create_resources('letsencrypt::config::domain', $domains)
}
