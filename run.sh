#!/bin/bash
if [ "$#" -eq 0 ]; then
	echo "No command/process type specified"
	exit 1
fi

if [ ! -d "/app" ]; then
	if [ -n "$GIT_REPO" ]; then
		git clone "$GIT_REPO" /app
		if [ -n "$GIT_REPO_TAG" ]; then
			pushd /app
			git checkout -b branch-$GIT_REPO_TAG origin/$GIT_REPO_TAG
			popd
		fi
		/build/builder
	else
		echo "No \$GIT_REPO environment variable defined"
		exit 1
	fi
fi

if [ "$1" == "/start" ]; then
	exec $@
else
	exec /exec $@
fi
