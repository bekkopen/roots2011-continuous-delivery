package { "nginx":
  ensure => present,
}

service { "nginx":
  enable => true,
}
