class lamprpm::runstagess {
  stage { "copyweb":  before  => Stage["main"] }
  stage { "post": require => Stage["main"] }
}

class copyweb   { notify { "class copyweb, first stage":   } }
class rpmmysql   { notify { "class rpmmysql, second stage":  } }
class post { notify { "class post, third stage": } }

# JJM We need Stage[pre] and Stage[post] in the catalog
include runstagess

# place Class[pre] in stage "pre"
class { "copyweb": stage => pre }
# default Class[main] to stage "main"
class { "rpmmysql": }
# place Class[post] in stage "post"
class { "post": stage => post }
