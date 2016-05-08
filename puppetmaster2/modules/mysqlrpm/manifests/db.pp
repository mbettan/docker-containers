class mysqlrpm::db {

exec { "sleep_db":
        path => ['/usr/bin', '/usr/sbin', '/bin'],
        command => "sleep 45",
}


# install mysql package

$password = "admin@123"
$mysql = [ "mysql", "mysql-server" ]

  exec { "Set MySQL server root password":
    subscribe => [ Package[ $mysql ] ],
    refreshonly => true,
    unless => "mysqladmin -uroot -p$password status",
    path => "/bin:/usr/bin",
    command => "mysqladmin -uroot password $password",
}
# ensure mysql service is running
service { 'mysqld':  ensure => running,}
}
