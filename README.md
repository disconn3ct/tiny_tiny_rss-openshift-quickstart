This is an OpenShift quickstart for Tiny Tiny RSS.

Once [the upstream bug](https://bugzilla.redhat.com/show_bug.cgi?id=950731) is fixed, this will be much simpler.

Creating an Openshift TT-RSS app:
=================================

To create an Openshift TT-RSS instance:

**Feel free to replace 'ttrss' with a different name.**

    $ rhc app create ttrss php-5.3 postgresql-8.4 cron-1.4
    Application Options
    -------------------
      Namespace:  spaces
      Cartridges: php-5.3, postgresql-8.4, cron-1.4
      Gear Size:  default
      Scaling:    no
    
    Creating application 'ttrss' ... done
    ...
    $ cd ttrss
    
Add my repository as 'upstream':

    $ git remote add upstream -m master https://github.com/disconn3ct/tiny_tiny_rss-openshift-quickstart.git

The next step is to overwrite the default application template:

    $ git pull -s recursive -X theirs upstream master

Update the app with the new code:

    $ git push

TTRSS will be installed, with a lot of output (but hopefully no errors.)

Updating the app:
=================
To update, just run a pull:

    $ git pull upstream master
    $ git push
