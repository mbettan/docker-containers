class tomcatmysql {

# install tomcat6 packages
$tomcat = [ "tomcat6", "tomcat6-admin-webapps", "tomcat6-webapps" ]
package { $tomcat:  ensure => installed,}

# ensure tomcat6 service is running
service { 'tomcat6': ensure => running,}

# install mysql package

$password = "admin@123"
$mysql = [ "mysql", "mysql-server" ]

  package { $mysql : ensure => installed, }

  exec { "Set MySQL server root password":
    subscribe => [ Package[ $mysql ] ],
    refreshonly => true,
    unless => "mysqladmin -uroot -p$password status",
    path => "/bin:/usr/bin",
    command => "mysqladmin -uroot password $password",
}
# ensure mysql service is running
service { 'mysqld':  ensure => running,}

}
