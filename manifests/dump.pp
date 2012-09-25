class mysql::dump($dbuser = "user", $dbpass = "secret", $dbname = 'test', $dbdumppath = "/vagrant/db_snapshot"){


	file{"${dbdumppath}":
		ensure => directory
	}


	exec { 'import-db':
		onlyif => "test -e ${$dbdumppath}/${dbname}_dev.sql",
		command => "/usr/bin/mysql ${dbname} < /vagrant/db_snapshot/${dbname}_dev.sql",
		require => Exec["create-db"],
	}

	file{"mysql-down.conf":
		path => "/etc/init/mysql-down.conf",
		content => template("mysql/mysql-down.conf.erb"),
		ensure => present,
	}
}
