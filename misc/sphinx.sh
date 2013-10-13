#! /bin/bash 
#   Based on the debian init.d script modified for openshift by
#   Michael Guntsche <mike@it-loops.com>
#
#              Written by Miquel van Smoorenburg <miquels@cistron.nl>.
#              Modified for Debian
#              by Ian Murdock <imurdock@gnu.ai.mit.edu>.
#              Further changes by Javier Fernandez-Sanguino <jfs@debian.org>
#              Modified for sphinx by Radu Spineanu <radu@debian.org>
#
#

DAEMON=${OPENSHIFT_REPO_DIR}/sphinx/bin/searchd
NAME=searchd
DESC=sphinxsearch

test -x $DAEMON || exit 0

PIDFILE=${OPENSHIFT_DATA_DIR}/run/sphinx-searchd.pid
DODTIME=1                   # Time to wait for the server to die, in seconds
                            # If this value is set too low you might not
                            # let some servers to die gracefully and
                            # 'restart' will not work

STARTDELAY=0.5

set -e

running_pid()
{
    # Check if a given process pid's cmdline matches a given name
    pid=$1
    name=$2
    [ -z "$pid" ] && return 1
    [ ! -d /proc/$pid ] &&  return 1
    cmd=`cat /proc/$pid/cmdline | tr "\000" "\n"|head -n 1 |cut -d : -f 1`
    # Is this the expected child?
    [ "$cmd" != "$name" ] &&  return 1
    return 0
}
running()
{
# Check if the process is running looking at /proc
# (works for all users)

    # No pidfile, probably no daemon present
    [ ! -f "$PIDFILE" ] && return 1
    # Obtain the pid and check it against the binary name
    pid=`cat $PIDFILE`
    running_pid $pid $DAEMON || return 1
    return 0
}

do_force_stop() {
# Forcefully kill the process
    [ ! -f "$PIDFILE" ] && return
    if running ; then
        kill -15 $pid
        # Is it really dead?
        [ -n "$DODTIME" ] && sleep "$DODTIME"s
        if running ; then
            kill -9 $pid
            [ -n "$DODTIME" ] && sleep "$DODTIME"s
            if running ; then
                echo "Cannot kill $NAME (pid=$pid)!"
                exit 1
            fi
        fi
    fi
    rm -f $PIDFILE
    return 0
}

case "$1" in
  start)
        echo -n "Starting $DESC: "
        if ! running ; then
          ${OPENSHIFT_REPO_DIR}/sphinx/bin/searchd --config ${OPENSHIFT_DATA_DIR}/sphinx/etc/sphinx.conf
          echo $NAME
        else
          echo "Already running"
        fi
        ;;
  stop)
        echo -n "Stopping $DESC: "
        ${OPENSHIFT_REPO_DIR}/sphinx/bin/searchd --config ${OPENSHIFT_DATA_DIR}/sphinx/etc/sphinx.conf --stop
        echo "$NAME."
        ;;
  restart|reload|force-reload)
        echo -n "Restarting $DESC: "

        if running ; then
	  ${OPENSHIFT_REPO_DIR}/sphinx/bin/searchd --config ${OPENSHIFT_DATA_DIR}/sphinx/etc/sphinx.conf --stop
        fi
        [ -n "$DODTIME" ] && sleep $DODTIME
        ${OPENSHIFT_REPO_DIR}/sphinx/bin/searchd --config ${OPENSHIFT_DATA_DIR}/sphinx/etc/sphinx.conf
        echo "$NAME."
        ;;

  force-stop)
        echo -n "Forcefully stopping $DESC: "
        do_force_stop
        if ! running ; then
            echo "$NAME."
        else
            echo "ERROR."
        fi
        ;;
  status)
    echo -n "$NAME is "
    if running ;  then
        echo "running"
    else
        echo "not running."
        exit 1
    fi
    ;;
  *)
    N=$NAME
    # echo "Usage: $N {start|stop|restart|reload|force-reload}" >&2
    echo "Usage: $N {start|stop|restart|force-reload|status|force-stop}" >&2
    exit 1

esac

exit 0
