file { "/tmp/configfile":
  content => "config=declarations\n",
}

exec { "output configfile contents":
  command => "echo /tmp/configfile",
  path => "/usr/sbin:/usr/bin:/sbin:/bin",
  subscribe => File["/tmp/configfile"],
  require => File["/tmp/configfile"],
  refreshonly => true,
}