class mysqlrpm::runstages {
  stage { "copy":  before  => Stage["main"] }
  stage { "rpm": require => Stage["main"] }
}

class copy   { notify { "class copy, first stage":   } }
class rpm   { notify { "class rpm, second stage":  } }

# JJM We need Stage[pre] and Stage[post] in the catalog
include runstages

# place Class[pre] in stage "pre"
class { "copy": stage => pre }
# default Class[main] to stage "main"
class { "rpm": }
