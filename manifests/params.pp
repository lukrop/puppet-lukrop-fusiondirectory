class fusiondirectory::params {
  $base_dn    = undef
  $admin_dn   = "cn=admin,${base_dn}"
  $admin_pw   = undef
  $ldap_uri   = 'ldap://localhost:389'
  $ldap_tls   = false
  $use_repo   = true
  $plugins    = []
  $schemas    = []
}
