define fusiondirectory::schema (
  $schema = $title,
  $ensure = present,
) {

  if $title == 'fusiondirectory' {
    if $fusiondirectory::use_repo {
      package { 'fusiondirectory-schema':
        ensure    => $ensure,
        require   => Apt::Source['fusiondirectory'],
      }
    } else {
      package { 'fusiondirectory-schema':
        ensure    => $ensure,
      }
    }

    $core_schemas = ['fusiondirectory/core-fd', 'fusiondirectory/core-fd-conf', 'fusiondirectory/ldapns', 'fusiondirectory/template-fd']
    openldap::server::schema { $core_schemas:
      ensure  => $ensure,
    }
  } else {
    if $fusiondirectory::use_repo {
      package { "fusiondirectory-plugin-${schema}-schema":
        ensure    => $ensure,
        require   => Apt::Source['fusiondirectory'],
      }
    } else {
      package { "fusiondirectory-plugin-${schema}-schema":
        ensure    => $ensure,
      }
    }

    if ($schema != 'freeradius') and
      ($schema != 'samba') {
      openldap::server::schema { "fusiondirectory-plugin-${schema}":
        ensure  => $ensure,
        path    => "/etc/ldap/schema/fusiondirectory/${schema}-fd.schema",
      }
    } else {
      # freeradius and samba schemas don't have the '-fd' suffix
      openldap::server::schema { "fusiondirectory-plugin-${schema}":
        ensure  => $ensure,
        path    => "/etc/ldap/schema/fusiondirectory/${schema}.schema",
      }
    }

    if ($schema != 'freeradius') and
      ($schema != 'dovecot') {
      openldap::server::schema { "fusiondirectory-plugin-${schema}-conf":
        ensure  => $ensure,
        path    => "/etc/ldap/schema/fusiondirectory/${schema}-fd-conf.schema",
        require => Openldap::Server::Schema["fusiondirectory-plugin-${schema}"],
      }
    }
  }

}
