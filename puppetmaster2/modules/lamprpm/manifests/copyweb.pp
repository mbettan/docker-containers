class lamprpm::copyweb {

file { "/root/httpd.tar.gz":
    ensure => directory,
    mode   => 440,
    owner  => root,
    group  => root,
    source => 'puppet:///modules/lamprpm/httpd.tar.gz',
}

exec { "sleep_web":
	path => ['/usr/bin', '/usr/sbin', '/bin'],
	command => "sleep 15",
}

exec { "tar_web":
        command => "/bin/tar xvf /root/httpd.tar.gz",
        subscribe => File["/root/httpd.tar.gz"],
        refreshonly => true,
}
}
