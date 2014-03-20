# == Class: freepbx::params
#
# See README.md for details
#
class freepbx::params {

  $version               = '2.11'
  $package_ensure        = 'present'
  $asterisk_user         = 'asterisk'
  $asterisk_group        = 'asterisk'
  $asterisk_db_user      = 'asteriskuser'
  $asterisk_git_repo_dir = '/usr/src/freepbx/framework'
  $vhost_docroot         = '/var/www'
}
