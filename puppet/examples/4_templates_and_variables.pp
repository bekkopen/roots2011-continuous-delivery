$port = 20202
$allowed_users = ["oc", "stein", "root"] # should never allow root

package { "openssh-server":
  ensure => present,
}

file { "/etc/ssh/sshd_config":
  content => template("sshd_config.erb"),
  require => Package["sshd"],
}

service { ssh:
  ensure => running,
  enable => true,
  hasstatus => true,
  subscribe => [Package["sshd"], File["/etc/ssh/sshd_config"]],
}