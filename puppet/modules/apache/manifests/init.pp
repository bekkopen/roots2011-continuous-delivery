class apache {

  package { 'httpd': ensure  => installed, }

  service { 'httpd': enable  => true, }

}