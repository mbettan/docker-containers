class lamprpm::rpmmysql {

exec {
  "rpm_mysql":
        path => ['/usr/bin', '/usr/sbin', '/bin'],
	cwd => "/root/mysqlrpms",
        command => "rpm -ivh --nodeps *.rpm ",
        }

#$password = "admin@123"
#$mysql = [ "mysql", "mysql-server" ]

#  exec { "Set MySQL server root password":
# require => Package['mysql'],
#    subscribe => [ Package[ $mysql ] ],
#    refreshonly => true,
#    unless => "mysqladmin -uroot -p$password status",
#    path => "/bin:/usr/bin",
#    command => "mysqladmin -uroot password $password",
#}

#ensure mysql service is running
service { 'mysqld':  ensure => running,}
}
