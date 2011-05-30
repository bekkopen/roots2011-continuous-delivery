group { "wheel":
    ensure => present,
    gid => 10,
}

user { "oc":
    ensure => present,
    gid => 10,
    uid => 1337,
    home => "/home/oc",
    managehome => true,
}

cron { "poor-mans-http-ping":
  command => "curl -s http://oc.rynning.no/ > /dev/null 2>&1",
  user => "oc",
  minute => "*/1", # Every minute
}