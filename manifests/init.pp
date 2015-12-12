# == Class: fusiondirectory
#
# Installs FusionDirectory webinterface, plugins and schemas.
#
# === Parameters
#
# === Examples
#
#  class { 'fusiondirectory':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Lukas Kropatschek <lukas@kropatschek.net>
#
# === Copyright
#
# Copyright 2015 Lukas Kropatschek, unless otherwise noted.
#
class fusiondirectory (
  $base_dn    = $fusiondirectory::params::base_dn,
  $admin_dn   = $fusiondirectory::params::admin_dn,
  $admin_pw   = $fusiondirectory::params::admin_pw,
  $ldap_uri   = $fusiondirectory::params::ldap_uri,
  $ldap_tls   = $fusiondirectory::params::ldap_tls,
  $use_repo   = $fusiondirectory::params::use_repo,

) inherits fusiondirectory::params {
  if !$base_dn or !$admin_pw {
    fail('Need base domain name and LDAP administrator password.')
  }

  if $use_repo {
    class { 'fusiondirectory::repository':
      ensure  => present,
    }
  } else {
    class { 'fusiondirectory::repository':
      ensure  => absent,
    }
  }

}
