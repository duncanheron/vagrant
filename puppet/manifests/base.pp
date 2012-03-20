exec { 'apt-get update': 
    command => '/usr/bin/apt-get update',
}

group { 'puppet':
    ensure => present,
}

package { 'php5':
    ensure => present,
    require => Exec['apt-get update'],
}

include apache

$password = "superSecurePa55word"
  package { "mysql-server": ensure => installed }
  package { "mysql-client": ensure => installed }
  
  exec { "Set MySQL server root password":
    subscribe => [ Package["mysql-server"], Package["mysql-client"] ],
    refreshonly => true,
    unless => "mysqladmin -uroot -p$password status",
    path => "/bin:/usr/bin",
    command => "mysqladmin -uroot password $password",
  }