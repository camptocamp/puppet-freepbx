# == Class: freepbx::service
#
# Service class for freepbx module
#
#   See README.md for details
#
class freepbx::service {

  exec { '/usr/local/sbin/amportal a reload':
    path        => [ '/var/lib/asterisk/bin','/usr/local/sbin','/usr/bin','/bin'],
    cwd         => '/var/lib/asterisk/bin',
    refreshonly => true,
  }

}


