#! /bin/bash
#
# Dockerfile entrypoint script run as root
# Requires container runtime conditions:
#   - mount /home 
#   - environment variables IPOPP_UID
#   - command/script to execute at the end
#

set -ux

[ $IPOPP_UID -gt 0 ] || {
  echo "Great security risk to use uid 0" >&2
  exit 1
}

# Create ipopp user
/usr/sbin/useradd -u $IPOPP_UID --shell '/bin/bash' --groups=wheel -M ipopp
chown -R ipopp:ipopp /home/ipopp
echo 'PS1="\[\e]0;\u@\h: \w\a\]\u@\h:\w$ "' >> /etc/profile

# If container is passed any argument, execute and exit
# Use sudo instead of su for better terminal/signal/argument handling
set -x
[ $# -gt 0 ] && exec gosu ipopp "$@"

# Drop into a shell if IPOPP is not yet installed
test -x /home/ipopp/drl/tools/services.sh || exec gosu ipopp bash -l

function shut_down() {
  echo "Caught signal" >&2
  gosu ipopp bash -l -c "/home/ipopp/drl/tools/services.sh stop"
  exit
}

trap "shut_down" SIGKILL SIGTERM SIGHUP SIGINT EXIT
gosu ipopp bash -l -c "/home/ipopp/drl/tools/services.sh start"
sleep 10s
gosu ipopp bash -l -c "/home/ipopp/drl/tools/services.sh status"

# this combination is needed to trap signals from container terminating
tail -f /home/ipopp/drl/is/logs/*.log /home/ipopp/drl/dsm/jsw/logs/*.log /home/ipopp/drl/nsls/jsw/logs/*.log
wait
