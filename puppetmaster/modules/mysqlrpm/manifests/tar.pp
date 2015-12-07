class mysqlrpm::tar {

exec { "tar":
        command => "/bin/tar -xzvf /root/mysqlrpms.tar.gz",
        subscribe => File["/root/mysqlrpms.tar.gz"],
        refreshonly => true,
}
}
