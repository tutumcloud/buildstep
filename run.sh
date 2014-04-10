#!/bin/bash
if [ ! -d "/app" ]; then
	if [ -n "$GIT_REPO" ]; then
		git clone "$GIT_REPO" /app
		/build/builder
	else
		echo "No \$GIT_REPO environment variable defined"
		exit 1
	fi
fi
if [ -f "/app/Procfile" ]; then
	exec /start "$@"
else
	exec /exec "$@"
fi
