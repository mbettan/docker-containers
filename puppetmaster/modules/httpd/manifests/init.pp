class httpd {

$mysql = [ "mysql", "mysql-server" ]

package { $mysql : ensure => installed, }

#ensure mysql & apache services are running

service { 'mysqld':  ensure => running, }

service { 'httpd':  ensure => running, }

# install php5 packages

$php = [ "php", "php-mysql" ]

package { $php : ensure => installed,
	notify => Service['httpd'],
 }

exec { httpd:
command => "/bin/echo 'Include conf.d/*.conf' >> '/etc/httpd/conf/httpd.conf'",
}

file { '/etc/httpd/conf.d/vhost.conf':
source => 'puppet:///modules/httpd/vhost.conf',
notify => Service['httpd'],
}
}
