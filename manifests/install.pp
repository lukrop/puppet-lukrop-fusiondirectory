class fusiondirectory::install ( $ensure = latest ) {
  if $fusiondirectory::use_repos {
    # install fusiondirectory using fd repos
    package { 'fusiondirectory':
      ensure => $ensure,
      require => Apt::Source['fusiondirectory'],
    }
  } else {
    # install fusiondirectory from debian repos
    package { 'fusiondirectory':
      ensure => $ensure,
    }
  }
}
