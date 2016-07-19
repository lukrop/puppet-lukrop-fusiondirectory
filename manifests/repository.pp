class fusiondirectory::repository ($ensure = present) {
  #include apt
  apt::source { 'fusiondirectory':
    ensure    => $ensure,
    location  => "http://repos.fusiondirectory.org/debian-$lsbdistcodename",
    release   => $lsbdistcodename,
    repos     => 'main',
    key       => {
      id      => '5636FC267B643B144F31BCA0E184859262B4981F',
      server  => 'keys.gnupg.net',
    },
    notify    => Exec['apt_update']
  }
}
