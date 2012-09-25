class mysql::create($dbuser = "user", $dbpass = "secret", $dbname = 'puppet'){

	exec { 'create-db':
		unless => "/usr/bin/mysql -u${dbuser} -p${dbpass} ${dbname}",
		command => "/usr/bin/mysql -e \"create database ${dbname}; grant all on ${dbname}.* to ${dbuser}@localhost identified by '${dbpass}';\"",
		require => Service["mysql"],
	}
}
