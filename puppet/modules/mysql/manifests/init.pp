class mysql::server {
  include mysql::client

  package { 'mysql-server':
    ensure  => installed,
  }

  service { 'mysqld':
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['mysql-server'],
  }

}

class mysql::client {
  package { 'mysql':
    ensure  => installed,
  }
}
