class mysqlrpm {

file { "/root/mysqlrpms.tar.gz":
    ensure => directory,
    mode   => 440,
    owner  => root,
    group  => root,
    source => 'puppet:///modules/mysqlrpm/mysqlrpms.tar.gz',
}

exec { "tar":
	command => "/bin/tar -xzvf /root/mysqlrpms.tar.gz",
}

exec { "rpm":
    path => ['/usr/bin', '/usr/sbin', '/bin'],
    cwd => "/root/mysqlrpms",
    command => "rpm -ivh --nodeps *.rpm ",
}

File['/root/mysqlrpms.tar.gz'] -> Exec['tar'] -> Exec['rpm']
}
