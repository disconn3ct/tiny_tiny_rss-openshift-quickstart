This is an OpenShift quickstart for Tiny Tiny RSS.

Creating an Openshift TT-RSS app:
=================================

To create an Openshift TT-RSS instance:

**Feel free to replace 'ttrss' with a different name.**

    $ rhc app create ttrss php-5.3 postgresql-8.4 cron-1.4 --from-code=https://github.com/disconn3ct/tiny_tiny_rss-openshift-quickstart.git --timeout=9999
    
    Application Options
    -------------------
      Namespace:  spaces
      Cartridges: php-5.3, postgresql-8.4, cron-1.4
      Gear Size:  default
      Scaling:    no

    Creating application 'ttrss' ... done

Note that it may instead say:

    Creating application 'ttrss' ... Server returned an unexpected error code: 504

That is ok, it is a bug with OpenShift. It probably succeeded, but you will have to manually clone the repo:

    $ rhc git-clone ttrss

Once you have a repository (manually or automatically) you will probably want to add my repository as 'upstream':

    $ cd ttrss
    $ git remote add upstream -m master https://github.com/disconn3ct/tiny_tiny_rss-openshift-quickstart.git

TTRSS is now installed!

Updating the template:
======================
To update, just run a pull from my repo and push into the Openshift instance:

    $ git pull upstream master
    $ git push

This will pull in any changes I've made, such as new release versions of TTRSS. It should not affect your existing data. It does take some time though, as Openshift goes through a complete application restart.

Updating TTRSS:
===============
If you want to change TTRSS versions without waiting for me, it is easy.

First make sure the submodule is initialized in your local repo:

    $ git submodule update --init --recursive

Then update as you like:

Updating to master (latest commits):

The first time, you have to set it to master:

    $ cd php
    $ git checkout master
    
After that, all that is necessary is:

    $ cd php
    $ git pull
    $ cd ..
    $ git add php
    $ git commit -m "update to lastest ttrss"
    $ git push

Updating to a specific tag/release (1.8 in this example):

    $ cd php
    $ git fetch
    $ git checkout 1.8
    $ cd ..
    $ git push
