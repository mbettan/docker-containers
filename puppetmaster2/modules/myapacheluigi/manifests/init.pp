class myapacheluigi {

  class { 'apache': }  

  file { "/var/www/html/index.html":
    ensure => present,
    source => "puppet:///modules/myapacheluigi/index.html",
  }
  
  file { "/var/www/html/luigi.jpg":
    ensure => present,
    source => "puppet:///modules/myapacheluigi/luigi.jpg",
  }

}