class lamprpm::post {

exec { "sleep_post":
        path => ['/usr/bin', '/usr/sbin', '/bin'],
        command => "sleep 45",
}

# ensure info.php file exists
file { '/var/www/html/info.php':
  ensure => file,
  content => '<?php  phpinfo(); ?>',    # phpinfo code
#  subscribe => [ Package[ httpd ] ],
#  require => Package['httpd'],        # require 'apache2' package before creating
}

$password = "admin@123"
#$mysql = [ "mysql", "mysql-server" ]

#  exec { "Set MySQL server root password":
#    require => [ Package[ $mysql ] ], 
#    subscribe => [ Package[ $mysql ] ],
#    refreshonly => true,
#    unless => "mysqladmin -uroot -p$password status",
#    path => "/bin:/usr/bin",
#    command => "mysqladmin -uroot password $password",
#}

}
