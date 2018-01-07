#!/bin/bash

set -e
trap "echo SIGNAL" HUP INT QUIT KILL TERM

if [ -n "$REPO_GIT" ]
then
	git config --system http.sslverify false
	git clone $REPO_GIT
fi

exec "$@"
