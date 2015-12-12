define fusiondirectory::plugin (
  $plugin = $title,
  $ensure = present,
) {
  if $plugin {
    if $fusiondirectory::use_repo {
      package { "fusiondirectory-plugin-${plugin}":
        ensure  => $ensure,
        require => Apt::Source['fusiondirectory'],
      }
    } else {
      package { "fusiondirectory-plugin-${plugin}":
        ensure  => $ensure,
      }
    }
  }
}
