class myapachemario {

  class { 'apache': }  

  file { "/var/www/html/index.html":
    ensure => present,
    source => "puppet:///modules/myapachemario/index.html",
  }
  
  file { "/var/www/html/mario.jpg":
    ensure => present,
    source => "puppet:///modules/myapachemario/mario.jpg",
  }

}