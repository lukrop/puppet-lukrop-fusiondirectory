# == Class: fusiondirectory
#
# Installs FusionDirectory webinterface, plugins and schemas.
#
# === Parameters
#
# [*ensure*]
#   presence of fusiondirectory package and repository.
# [*base_dn*]
#   LDAP base DN
# 
# [*admin_dn*]
#   LDAP administrator account DN
#   Default: "cn=admin,${base_dn}"
# 
# [*admin_pw*]
#   LDAP administrator password
# 
# [*ldap_uri*]
#   LDAP URI
#   Default: 'ldap://localhost:389'
# 
# [*ldap_tls*]
#   use TLS for the LDAP connection
#   Default: false
# 
# [*use_repo*]
#   Use the official fusiondirectory apt repository.
#   Default: true
# 
# [*plugins*]
#   Array containing plugins to install.
# 
# [*schemas*]
#   Array containing schemas to install.
# 
#
# === Examples
#
#   class { 'fusiondirectory':
#     ensure    => present,
#     base_dn   => 'dc=example,dc=com',
#     admin_pw  => 'supersecret',
#     ldap_tls  => true,
#   }
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
  $ensure,
  $base_dn  = $fusiondirectory::params::base_dn,
  $admin_dn = $fusiondirectory::params::admin_dn,
  $admin_pw = $fusiondirectory::params::admin_pw,
  $ldap_uri = $fusiondirectory::params::ldap_uri,
  $ldap_tls = $fusiondirectory::params::ldap_tls,
  $use_repo = $fusiondirectory::params::use_repo,
  $plugins  = $fusiondirectory::params::plugins,
  $schemas  = $fusiondirectory::params::schemas,
) inherits fusiondirectory::params {
  if $use_repo {
    class { 'fusiondirectory::repository':
      ensure  => present,
    }
  } else {
    class { 'fusiondirectory::repository':
      ensure  => absent,
    }
  }
  
  if $ensure == present {
    if !$base_dn or !$admin_pw {
      fail('Need base domain name and LDAP administrator password.')
    }

    package { 'fusiondirectory':
      ensure  => installed,
      require => Class['fusiondirectory::repository'],
    }
  } else {
    package { 'fusiondirectory':
      ensure => absent,
    }
  }

  if !empty($plugins) {
    fusiondirectory::plugin { $plugins:
      ensure  => present,
      require => Class['fusiondirectory::repository'],
    }
  }

  if !empty($schemas) {
    fusiondirectory::schema { $schemas:
      ensure  => present,
      require => Class['fusiondirectory::repository'],
    }
  }
}

