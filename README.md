Introduction
============

This module try to install and setup freepbx from git repository.
After the first run, you should finish freepbx install by going on http://nodename/admin/config.php

Compatibility
=============

This module has been tested on debian 7 (wheezy)

Requires
========

- This module uses exec for mysql initialisation. an Exec path should be set. 
- Requires [camptocamp puppet-mysql module](https://github.com/camptocamp/puppet-mysql)


About
=====

Work inspired by [Debian install page on Freepbx wiki](http://wiki.freepbx.org/display/HTGS/Installing+FreePBX+on+Debian+Wheezy)

Parameters
==========

* [*version*]

  Release version of freepbx to download and install.
  At time of writing this module, version 2.11, 2.10 and 12 are available.
  This parameter must be set.

* [*vhost_name*]

  Name user in apache for asterisk vhost.
  This parameter must be set.

* [*package_ensure*]

  Set if freepbx module should install packages.
  Value: present or absent. Defaults to Present

* [*asterisk_user*]

  Specify user name for the daemon asterisk. defaults to 'asterisk'.

* [*asterisk_group*]

  Specify user group for the daemon asterisk. defaults to 'asterisk'.

* [*asterisk_db_user*]

  mysql user for asterisk and freepbx

* [*asterisk_db_pass*]

  mysql password for asterisk and freepbx

* [*asterisk_git_repo_dir*]

  local directory user for git repository download.
  Defaults to '/usr/src/freepbx/framework'.

* [*vhost_docroot*]

  DocumentRoot for apache vhost.
  Defaults to '/var/www'.

Example
=======

 class { 'freepbx':
   version          => '2.11',
   vhost\_name       => 'freepbx.example.com',
   asterisk\_db\_pass => 'changemeasIamaweakpassword',
 }

Authors
=======

Simon Séhier <simon.sehier@camptocamp.com>

Copyright
=========

Copyright 2014 Simon Séhier, Camptocamp.com

