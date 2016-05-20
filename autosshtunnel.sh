#! /bin/bash

# For each tunnel; make a uniquely named copy of this template.


## SETTINGS
#
# autossh monitoring port (unique)
MPORT=54321
# the ssh tunnel to setup
TUNNEL="-R 8888:localhost:22"
# remote user
RUSER="archer"

# remote server
RSERVER="115.28.70.69"
# You must use the real autossh binary, not a wrapper.
DAEMON=/usr/lib/autossh/autossh
#
## END SETTINGS

# PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
PATH=/home/archer/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games

NAME=`basename $0`
PIDFILE=/var/run/${NAME}.pid
SCRIPTNAME=/etc/init.d/${NAME}
DESC="the tunnel"

test -x $DAEMON || exit 0

export AUTOSSH_PORT=${MPORT}
export AUTOSSH_PIDFILE=${PIDFILE}
ASOPT=${TUNNEL}" -f -N "${RUSER}"@"${RSERVER}

#  Function that starts the daemon/service.
d_start() {
   start-stop-daemon --start --quiet --pidfile $PIDFILE \
      --exec $DAEMON -- $ASOPT
   if [ $? -gt 0 ]; then
       echo -n " not started (or already running)"
   else
       sleep 1
       start-stop-daemon --stop --quiet --pidfile $PIDFILE \
      --test --exec $DAEMON > /dev/null || echo -n " not started"
   fi

}

#  Function that stops the daemon/service.
d_stop() {
   start-stop-daemon --stop --quiet --pidfile $PIDFILE \
      --exec $DAEMON \
      || echo -n " not running"
}

case "$1" in
  start)
   echo -n "Starting $DESC: $NAME"
   d_start
   echo "."
   ;;
  stop)
   echo -n "Stopping $DESC: $NAME"
   d_stop
   echo "."
   ;;
 restart)
   echo -n "Restarting $DESC: $NAME"
   d_stop
   sleep 1
   d_start
   echo "."
   ;;
  *)
   echo "Usage: $SCRIPTNAME {start|stop|restart}" >&2
   exit 3
   ;;
esac

exit 0
