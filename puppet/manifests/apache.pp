class apache 
{
	package { 'apache2': 
	    ensure => present,
	    require => Exec['apt-get update'],
	}

	file { "/etc/apache2/sites-available/vhost.conf":
		ensure => file,
		owner => root,
		group => root,
		mode => 0644,
		source => 'puppet:///modules/apache2/vhost.conf',
		require => Package['apache2'],
		notify => Service["apache2"],
	}

	file { "/etc/apache2/sites-enabled/vhost.conf":
		path => "/etc/apache2/sites-enabled/vhost.conf",
	    target => "/etc/apache2/sites-available/vhost.conf",
	    ensure => link,
		require => File["/etc/apache2/sites-available/vhost.conf"],
		notify => Service["apache2"],
	}
	
	file { "/etc/apache2/sites-enabled/000-default":
		ensure => absent,
		require => File["/etc/apache2/sites-enabled/vhost.conf"],
		notify => Service["apache2"],
	}

	service { 'apache2':
	    ensure => running,
	    require => Package['apache2'],

	}
}