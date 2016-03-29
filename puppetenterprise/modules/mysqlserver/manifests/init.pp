class mysqlserver {

  class { '::mysql::server':
    root_password    => 'strongpassword',
    override_options => { 'mysqld' => { 'max_connections' => '1024' } }
  }

  mysql::db { 'statedb':
    user     => 'admin',
    password => 'secret',
    sql        => '/tmp/states.sql',
    require => File['/tmp/states.sql'],
  }

  file { "/tmp/states.sql":
    ensure => present,
    source => "puppet:///modules/mysqlserver/states.sql",
  }

  mysql_user { 'bob@localhost':
    ensure                   => 'present',
    max_connections_per_hour => '60',
    max_queries_per_hour     => '120',
    max_updates_per_hour     => '120',
    max_user_connections     => '10',
  }
}