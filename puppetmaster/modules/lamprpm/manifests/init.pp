class lamprpm {

include lamprpm::copyweb, lamprpm::copymysql, lamprpm::rpmweb, lamprpm::rpmmysql, lamprpm::post
}


#class { 'lamprpm::runstages':}

class { 'lamprpm::copyweb':}

class { 'lamprpm::copymysql':}

class { 'lamprpm::rpmmysql': 
#   require => Notify['Tar Complete']
}

class { 'lamprpm::rpmweb':
#require => Notify['Tar Complete']
}

class { 'lamprpm::post': 
#   require => Notify['RPM Web Complete']
}


#notify { 'Tar Complete':
#        require => Class['lamprpm::copymysql']
#    }

#notify { 'RPM Complete':
#       require => Class['lamprpm::rpmmysql']
#    }

#notify { 'RPM Web Complete':
#       require => Class['lamprpm::rpmweb']
#    }

#}

Class["lamprpm::copyweb"] -> Class["lamprpm::copymysql"] -> Class["lamprpm::rpmweb"] -> Class["lamprpm::rpmmysql"] -> Class["lamprpm::post"]
