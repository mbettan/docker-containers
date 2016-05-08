class lamp {

# install apache2 package
package { 'httpd':
  ensure => installed,
}

# ensure apache2 service is running
service { 'httpd':
  ensure => running,
}

# install mysql package

$password = "admin@123"
$mysql = [ "mysql", "mysql-server" ]

  package { $mysql : ensure => installed, }

  exec { "Set MySQL server root password":
    subscribe => [ Package[ $mysql ] ],
    refreshonly => true,
    unless => "mysqladmin -uroot -p$password status",
    path => "/bin:/usr/bin",
    command => "mysqladmin -uroot password $password",
}
# ensure mysql service is running

service { 'mysqld':
  ensure => running,
}

# install php5 package
package { 'php':
  ensure => installed,
}

# ensure info.php file exists
file { '/var/www/html/info.php':
  ensure => file,
  content => '<?php  phpinfo(); ?>',    # phpinfo code
  require => Package['httpd'],        # require 'apache2' package before creating
}
}
