class puppet::agent {
  file { "/etc/sysconfig":
      ensure => directory,
  }

  #file { "/etc/sysconfig/puppet":
  #    source => "puppet:///modules/puppet/templates/puppet.erb",
  #    require => [ Package[puppet], File['/etc/sysconfig'] ],
  #}

  file { "/etc/puppet/puppet.conf":
    source => "puppet:///modules/puppet/puppet.conf",
  }

  package { 'puppet': ensure => present }
  package { 'ruby-rdoc': ensure => present } # For command-line help
}

class puppet::master {

  include puppet::agent

  #file { "/etc/sysconfig/puppetmaster":
  #    source => "puppet:///modules/puppet/templates/puppetmaster.erb",
  #    require => [ Package[puppet-server] ],
  #}

  package { 'puppet-server': ensure => present }
}