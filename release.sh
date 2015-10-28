#!/bin/bash -e

if [ "$1" == "" ]; then
  echo "Usage $0 <RELEASE>"
  exit 1
fi

git checkout master
if [ "$(git diff master)" != "" ]; then
  echo "Make sure your working tree is clean and you are on the master branch."
  exit 1
fi

echo "Releasing version $1"

echo "VERSION=$1" > VERSION
$EDITOR CHANGELOG.md

git add VERSION CHANGELOG.md
git commit -m "Release version $1"
git tag v$1 master

git show
echo "Are you sure you want to push? Press ENTER"
read

git push origin master
git push origin v$1
