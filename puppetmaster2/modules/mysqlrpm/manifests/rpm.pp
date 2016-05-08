class mysqlrpm::rpm {

exec {
  "rpm":
        path => ['/usr/bin', '/usr/sbin', '/bin'],
	cwd => "/root/mysqlrpms",
        command => "rpm -ivh --nodeps *.rpm ",
        }
# ensure mysql service is running
service { 'mysqld':  ensure => running,}
}
