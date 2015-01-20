#!/bin/bash
if [ "$#" -eq 0 ]; then
	echo "No command/process type specified"
        exit 1
fi

if [ ! -d "/app" ]; then
	if [ -n "$GIT_REPO" ]; then
		git clone "$GIT_REPO" /app
	elif [ "true" = `echo "$USE_LOCAL_REPO" | tr [:upper:] [:lower:]` ]; then
		cp /localrepo/ /app/ -r
	else
		echo "No repo defined"
		exit  1
	fi
	/build/builder
fi

exec /exec "$@"
