class fusiondirectory::repository ($ensure = present) {
    include apt
    apt::key { 'fusiondirectory-key':
      ensure  => $ensure,
      id      => '5636FC267B643B144F31BCA0E184859262B4981F',
      server  => 'keys.gnupg.net',
    }
    #if $::facts['os']['release']['major'] == "8" {
      apt::source { 'fusiondirectory':
        ensure  => $ensure,
        location  => 'http://repos.fusiondirectory.org/debian-jessie',
        release   => 'jessie',
        repos     => 'main',
        require   => Apt::Key['fusiondirectory-key']
      }
    #}
    #if $::facts['os']['release']['major'] == "7" {
    #  apt::source { 'fusiondirectory':
    #    ensure  => $ensure,
    #    location  => 'http://repos.fusiondirectory.org/debian-wheezy',
    #    release   => 'wheezy',
    #    repos     => 'main',
    #    require   => Apt::Key['fusiondirectory-key']
    #  }
    #  apt::source { 'fusiondirectory-extra':
    #    ensure  => $ensure,
    #    location  => 'http://repos.fusiondirectory.org/debian-extra',
    #    release   => 'wheezy',
    #    repos     => 'main',
    #    require   => Apt::Key['fusiondirectory-key']
    #  }
    #}
}
