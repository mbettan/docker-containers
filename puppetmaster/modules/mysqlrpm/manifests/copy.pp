class mysqlrpm::copy {

file { "/root/mysqlrpms.tar.gz":
    ensure => directory,
    mode   => 440,
    owner  => root,
    group  => root,
    source => 'puppet:///modules/mysqlrpm/mysqlrpms.tar.gz',
}

#exec { "sleep_before_tar":
#	path => ['/usr/bin', '/usr/sbin', '/bin'],
#	command => "sleep 10",
#}

exec { "tar":
        command => "/bin/tar -xzvf /root/mysqlrpms.tar.gz",
        subscribe => File["/root/mysqlrpms.tar.gz"],
        refreshonly => true,
}
}
