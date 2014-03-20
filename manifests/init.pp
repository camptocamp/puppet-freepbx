# == Class: freepbx
#
# freepbx module
#
# === Parameters
# [*version*]
#
#   Release version of freepbx to download and install.
#   At time of writing this module, version 2.11, 2.10 and 12 are available.
#   This parameter must be set.
#
# [*vhost_name*]
#
#   Name user in apache for asterisk vhost.
#   This parameter must be set.
#
# [*package_ensure*]
#
#   Set if freepbx module should install packages.
#   Value: present or absent. Defaults to Present
#
# [*asterisk_user*]
#
#   Specify user name for the daemon asterisk. defaults to 'asterisk'.
#
# [*asterisk_group*]
#
#   Specify user group for the daemon asterisk. defaults to 'asterisk'.
#
# [*asterisk_db_user*]
#
#   mysql user for asterisk and freepbx
#
# [*asterisk_db_pass*]
#
#   mysql password for asterisk and freepbx
#
# [*asterisk_git_repo_dir*]
#
#   local directory user for git repository download.
#   Defaults to '/usr/src/freepbx/framework'.
#
# [*vhost_docroot*]
#
#   DocumentRoot for apache vhost.
#   Defaults to '/var/www'.
#
# === Example
#
#  class { 'freepbx':
#    version          => '2.11',
#    vhost_name       => 'freepbx.example.com',
#    asterisk_db_pass => 'changemeasIamaweakpassword',
#  }
#
# === Authors
#
# Simon Séhier <simon.sehier@camptocamp.com>
#
# === Copyright
#
# Copyright 2014 Simon Séhier, Camptocamp.com
#
class freepbx (
  $version               = $freepbx::params::version,
  $package_ensure        = $freepbx::params::package_ensure,
  $asterisk_user         = $freepbx::params::asterisk_user,
  $asterisk_group        = $freepbx::params::asterisk_group,
  $asterisk_db_user      = $freepbx::params::asterisk_db_user,
  $asterisk_db_pass      = $freepbx::params::asterisk_db_pass,
  $asterisk_git_repo_dir = $freepbx::params::asterisk_git_repo_dir,
  $vhost_name            = $freepbx::params::vhost_name,
  $vhost_docroot         = $freepbx::params::vhost_docroot,
) inherits freepbx::params {

  validate_re($version, ['2.11','2.10','12.0'])
  validate_string($vhost_name)
  validate_string($asterisk_db_pass)
  validate_absolute_path($vhost_docroot)

  class { 'freepbx::install': } ->
  class { 'freepbx::config': } ~>
  class { 'freepbx::service': } ->
  Class ['freepbx']
}
