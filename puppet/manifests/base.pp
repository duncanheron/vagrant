group { 'puppet':
    ensure => present,
}

exec { 'apt-get update': 
    command => '/usr/bin/apt-get update',
}

package { 'apache2': 
    ensure => present,
    require => Exec['apt-get update'],
}

package { 'php5':
    ensure => present,
    require => Exec['apt-get update'],
}


file { "/etc/apache2/sites-available/vhost.conf":
	ensure => file,
	owner => root,
	group => root,
	mode => 0644,
	source => 'puppet:///modules/apache2/vhost.conf',
	notify => Service["apache2"]
}
file { "/etc/apache2/sites-enabled/vhost.conf":
	ensure => "/etc/apache2/sites-available/vhost.conf",
	require => File["/etc/apache2/sites-available/vhost.conf"],
	notify => Service["apache2"]
}
file { "/etc/apache2/sites-enabled/000-default":
	ensure => absent,
	require => File["/etc/apache2/sites-enabled/vhost.conf"],
	notify => Service["apache2"]
}

service { 'apache2':
    ensure => running,
    require => Package['apache2'],

}
