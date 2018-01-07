#!/bin/bash

set -e
trap "echo SIGNAL" HUP INT QUIT KILL TERM

if [ "${1:0:1}" = "-" ] ; then
	exec /usr/sbin/vsftpd "$@"
fi

if [ "$1" = "/usr/sbin/vsftpd" ] ; then
	exec "$@"
fi

if [ "$1" = "vsftpd" ] ; then
	exec /usr/sbin/vsftpd
fi

exec "$@"
