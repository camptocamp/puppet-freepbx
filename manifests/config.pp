# == Class: freepbx::config
#
# Config class for freepbx module
#
#   See README.md for details
#
class freepbx::config {

  File {
    owner   => $freepbx::asterisk_user,
    group   => $freepbx::asterisk_group,
  }

  file { $freepbx::vhost_docroot:
    ensure  => directory,
  }

  include ::apache
  apache::vhost { $freepbx::vhost_name:
    port    => 80,
    docroot => $freepbx::vhost_docroot,
  }

  augeas{'freepbx PHP setting':
    lens    => 'PHP.lns',
    incl    => '/etc/php5/apache2/php.ini',
    changes => 'set PHP/upload_max_filesize 120M',
  }

  # mysql:
  include ::mysql::server

  mysql::db { 'asterisk':
    ensure   => present,
    user     => $freepbx::asterisk_db_user,
    password => $freepbx::asterisk_db_pass,
  }

  mysql::db { 'asteriskcdrdb':
    ensure   => present,
    user     => $freepbx::asterisk_db_user,
    password => $freepbx::asterisk_db_pass,
  }

  $mysql_user     = $::mysql::server::options['mysqld']['user']
  $mysql_password = $::mysql::server::root_password


  # We could translate these SQL scripts into puppet receipt, but then this
  # module would be obsolete every new version of freepbx's SQL scripts
  exec { 'mysql newinstall.sql':
    command     => "mysql --user=${mysql_user} --database=asterisk < ${freepbx::asterisk_git_repo_dir}/SQL/newinstall.sql",
    cwd         => $freepbx::asterisk_git_repo_dir,
    environment => "MYSQL_PWD=${mysql_password}",
    unless      => "mysql --user=${mysql_user} asterisk -e \"SELECT * FROM dahdichandids LIMIT 1;\"",
    path        => $::path,
  }

  exec { 'mysql cdr_nmysql_table.sql':
    command     => "mysql --user=${mysql_user} --database=asteriskcdrdb  < ${freepbx::asterisk_git_repo_dir}/SQL/cdr_mysql_table.sql",
    cwd         => $freepbx::asterisk_git_repo_dir,
    environment => "MYSQL_PWD=${mysql_password}",
    unless      => "mysql --user=${mysql_user} asteriskcdrdb -e \"SELECT * FROM cdr LIMIT 1;\"",
    path        => $::path,
  }


  # Now, install freepbx:
  ## start asterisk
  exec { "${freepbx::asterisk_git_repo_dir}/start_asterisk start":
    cwd    => $freepbx::asterisk_git_repo_dir,
    unless => 'pgrep asterisk',
    path   => $::path,
  }

  exec { "${freepbx::asterisk_git_repo_dir}/install_amp --username=${freepbx::asterisk_db_user} --password=${freepbx::asterisk_db_pass} --webroot ${freepbx::vhost_docroot}":
    cwd     => $freepbx::asterisk_git_repo_dir,
    creates => '/usr/local/sbin/amportal',
    path    => $::path,
  }

  file { "${freepbx::vhost_docroot}/admin/modules/_cache/":
    ensure => directory,
  }

}
