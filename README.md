# fusiondirectory

#### Table of Contents

1. [Overview](#overview)
2. [Description](#description)
3. [Setup](#setup)
    * [What fusiondirectory affects](#what-fusiondirectory-affects)
    * [Beginning with fusiondirectory](#beginning-with-fusiondirectory)
4. [Usage](#usage)
5. [Reference](#reference)

## Overview

This puppet module lets you easily install [https://www.fusiondirectory.org/](FusionDirectory) on
Debian (based) systems.

## Description

If applicable, this section should have a brief description of the technology
the module integrates with and what that integration enables. This section
should answer the questions: "What does this module *do*?" and "Why would I use
it?"

If your module has a range of functionality (installation, configuration,
management, etc.) this is the time to mention it.

## Setup

### What fusiondirectory affects

* Installs the fusiondirectory package
* Installs plugin packages listed by the user
* By default adds the apt repository of fusiondirectory and installs packages from there
* Installs schema packages listed by the user as well as inserts those schemas using the [https://forge.puppetlabs.com/camptocamp/openldap/](camptocamp-openldap) puppet module.

### Beginning with fusiondirectory

Currently the module is only available from github so you'll have to clone it and install it's dependencies by hand.

Install required modules:
```shell
puppet module install puppetlabs-apt camptocamp-openldap
```
Then clone this repository:
```shell
git clone https://github.com/lukrop/puppet-lukrop-fusiondirectory.git fusiondirectory
```

## Usage
Install fusiondirectory
```puppet
class { 'fusiondirectory':
  ensure    => present,
  base_dn   => 'dc=example,dc=com',
  admin_pw  => 'supersecret',
  ldap_tls  => true,
}
```
Install plugins
```puppet
$plugins = ['fusiondirectory', 'samba', 'freeradius', 'mail']
fusiondirectory::plugin { $schemas:
  ensure  => present,
}
```
Install only schemas:
```puppet
$schemas = ['fusiondirectory', 'samba', 'freeradius', 'mail']
fusiondirectory::schema { $schemas:
  ensure  => present,
}
```

## Reference
`fusiondirectory` parameters
 * `ensure`
   presence of fusiondirectory package and repository.

 * `base_dn`
   LDAP base DN
 
 * `admin_dn`
   LDAP administrator account DN
   Default: "cn=admin,${base_dn}"
 
 * `admin_pw`
   LDAP administrator password
 
 * `ldap_uri`
   LDAP URI
   Default: 'ldap://localhost:389'
 
 * `ldap_tls`
   use TLS for the LDAP connection
   Default: false
 
 * `use_repo`
   Use the official fusiondirectory apt repository.
   Default: true
 
 * `plugins` 
   Array containing plugins to install.
 
 * `schemas`
   Array containing schemas to install.

