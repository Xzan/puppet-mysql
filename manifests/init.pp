class mysql($dbrootpass = 'vagrant'){

	user { "mysql":
  	  ensure => present,
  	  require => Package["mysql-server"],
  	}

	package { "mysql-server" :
		ensure => installed
	}
	
	package { "mysql-client" :
		ensure => installed
	}
	
	exec { "Set MySQL server root password":
		subscribe => [ Package["mysql-server"], Package["mysql-client"] ],
		refreshonly => true,
		unless => "mysqladmin -uroot -p$dbrootpass status",
		path => "/bin:/usr/bin",
		command => "mysqladmin -uroot password $dbrootpass",
	}

	package { "libapache2-mod-auth-mysql":
		ensure => installed
	}

	package { "php5-mysql":
		ensure => installed
	}

	service { "mysql":
		ensure      => running,
		enable      => true,
		name        => "mysql",
		require   => Package["mysql-server"],
	}


}
