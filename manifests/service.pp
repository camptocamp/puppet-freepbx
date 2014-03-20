# == Class: freepbx::service
#
# Service class for freepbx module
#
#   See README.md for details
#
class freepbx::service {

  exec { '/usr/local/sbin/amportal a reload':
    refreshonly => true,
  }

}


