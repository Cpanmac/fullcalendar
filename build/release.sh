#!/usr/bin/env bash

cd "`dirname $0`/.."

read -p "Enter the new version number with no 'v' (for example '1.0.1'): " version

if [[ ! "$version" ]]
then
	exit
fi

grunt bump --setversion=$version && \
grunt dist && \
git add -f dist/*.js dist/*.css dist/lang/*.js && \
git commit -a -e -m "version $version" && \
git tag -a v$version -m "version $version"

status=$?

# regardless of error/success
git reset

if [ $status -eq 0 ]
then
	echo
	echo 'DONE. It is now up to you to run `'"git push origin master && git push origin v$version"'`'
	echo
	echo 'and `npm publish`'
	echo
fi