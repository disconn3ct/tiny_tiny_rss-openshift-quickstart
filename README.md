This is an OpenShift quickstart for Tiny Tiny RSS.

Once [the other upstream bug](https://bugzilla.redhat.com/show_bug.cgi?id=975540) is fixed, this will be much simpler.

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

Remove the existing 'php' directory:

    $ git rm -r php ; git commit -m "remove php"

The next step is to overwrite the default application template:

    $ git pull -s recursive --no-edit --commit -X theirs upstream master

Update the app with the new code:

    $ git push

TTRSS will be installed, with a lot of output (but hopefully no errors.)

Updating the template:
======================
To update, just run a pull:

    $ git pull upstream master
    $ git push
    
Updating TTRSS:
===============
If you want to change TTRSS versions, it is easy.

First make sure the submodule is initialized in your repository:

	$ git submodule update --init --recursive

Then update as you like:

Updating to master (latest commits):

    $ cd php
    $ git pull
    $ cd ..
    $ git push

Updating to a specific tag/release:

    $ cd php
    $ git fetch
    $ git checkout 1.8
    $ cd ..
    $ git push
    
