This is a quickstart for Tiny Tiny RSS, based loosely off of 
https://github.com/fabianofranz/tiny_tiny_rss-openshift-quickstart

Once the upstream bug is fixed, this will be much simpler. (--from-code doesn't work as expected.)

To create an Openshift TT-RSS instance:
$ rhc app create ttrss php-5.3 postgresql-8.4
(Feel free to replace 'ttrss' with a different name.)
Application Options
-------------------
  Namespace:  spaces
  Cartridges: php-5.3, postgresql-8.4
  Gear Size:  default
  Scaling:    no

Creating application 'ttrss' ... done
...output snipped...
$ cd ttrss
Add my repository as 'upstream' and overwrite the blank template:
$ git remote add upstream -m master https://github.com/disconn3ct/tiny_tiny_rss-openshift-quickstart.git
$ git pull -s recursive -X theirs upstream master
...git output snipped...
Update the app with the new code:
$ git push
...TTRSS will be installed...

To update, just use "git pull" as normal.

Repo layout
===========
php/ - A submodule including a fork of the upstream TTRSS code. (The fork
       exists to allow for a config.php and the mobile submodule.)
php/mobile - Submodule holding the mobile plugin from
             https://github.com/mboinet/ttrss-mobile
libs/ - Additional libraries
misc/ - For PHP code that should not be accessible by end users

