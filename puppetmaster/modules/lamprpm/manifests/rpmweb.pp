class lamprpm::rpmweb {

exec {
  "rpm_web":
        path => ['/usr/bin', '/usr/sbin', '/bin'],
	cwd => "/root/httpd",
        command => "rpm -ivh --nodeps *.rpm ",
        }
# ensure httpd service is running
service { 'httpd':  ensure => running,}

# ensure info.php file exists
#file { '/var/www/html/info.php':
#  ensure => file,
#  content => '<?php  phpinfo(); ?>',    # phpinfo code
#  require => Package['httpd'],        # require 'apache2' package before creating
#}

}
