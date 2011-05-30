class ssh {
  $port = 22
  $allow_users = []
  file { '/etc/ssh':
    ensure => directory,
    mode   => 0755,
    owner  => root,
    group  => root,
  }
  user { sshd:
    uid       => 74, gid => 74,
    home      => "/var/empty/sshd",
    shell     => "/sbin/nologin",
    allowdupe => false,
  }
  group { sshd:
    gid       => 74,
    allowdupe => false,
  }
  package { 'openssh-clients':
    ensure  => installed,
    require => [ File["/etc/ssh"] ]
  }

  package { 'openssh-server':
    ensure  => installed,
    require => [ File["/etc/ssh"], User[sshd], Group[sshd] ]
  }
  service { 'sshd':
    ensure    => running,
    pattern   => 'sshd',
    require   => Package["openssh-server"],
    subscribe => [ File["/etc/ssh"], User[sshd], Group["sshd"] ]
  }
}