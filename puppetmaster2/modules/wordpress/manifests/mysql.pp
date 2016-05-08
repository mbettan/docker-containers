class mysql {
$mysql = [ "mysql", "mysql-server" ]


  package { $mysql : ensure => installed, }

# ensure mysql & apache services are running

service { 'mysqld':  ensure => running, }

service { 'httpd':  ensure => running, }

# install php5 packages
$php = [ "php", "php-mysql" ]

package { $php : ensure => installed, }
}
