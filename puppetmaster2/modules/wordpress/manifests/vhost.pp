class vhost {

file { '/etc/httpd/sites-available':
        ensure => 'directory',
}

file { '/etc/httpd/sites-enabled':
        ensure => 'directory',
}

file { '/etc/httpd/sites-available/':
source => 'puppet:///modules/wordpress/files/vhost.conf',
 notify => Service['httpd'],
}

exec { httpd:
command => "/bin/echo 'IncludeOptional sites-enabled/*.conf' >> '/etc/httpd/conf/httpd.conf'",
}

file { '/etc/httpd/site-available/vhost.conf':
   ensure => 'link',
   target => '/etc/httpd/site-enabled/vhost.conf',
 notify => Service['httpd'],
}
}
