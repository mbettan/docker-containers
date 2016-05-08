class lamprpm::copymysql {

file { "/root/mysqlrpms.tar.gz":
    ensure => directory,
    mode   => 440,
    owner  => root,
    group  => root,
    source => 'puppet:///modules/lamprpm/mysqlrpms.tar.gz',
}

exec { "sleep":
	path => ['/usr/bin', '/usr/sbin', '/bin'],
	command => "sleep 15",
}

exec { "tar":
        command => "/bin/tar xvf /root/mysqlrpms.tar.gz",
        subscribe => File["/root/mysqlrpms.tar.gz"],
        refreshonly => true,
}
}
