class lamprpm::xxdb::rpmmysql {

exec { "sleep_db":
        path => ['/usr/bin', '/usr/sbin', '/bin'],
        command => "sleep 45",
}


# install mysql package


$password = "admin@123"
$mysql = [ "mysql", "mysql-server" ]

  exec { "Set MySQL server root password":
    ensure => present,
    require => Class ['lamprpm::rpmmysql'],
    subscribe => [ Package[ $mysql ] ],
    refreshonly => true,
    unless => "mysqladmin -uroot -p$password status",
    path => "/bin:/usr/bin",
    command => "mysqladmin -uroot password $password",
}
}
