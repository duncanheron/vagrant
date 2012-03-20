class mysql
{
  $password = "superSecurePa55word"
  package { "mysql-server": ensure => installed }
  package { "mysql": ensure => installed }
  
  exec { "Set MySQL server root password":
    subscribe => [ Package["mysql-server"], Package["mysql"] ],
    refreshonly => true,
    unless => "mysqladmin -uroot -p$password status",
    path => "/bin:/usr/bin",
    command => "mysqladmin -uroot password $password",
  }
}