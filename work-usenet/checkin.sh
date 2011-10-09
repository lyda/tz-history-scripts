#!/bin/bash

f="$1"
email="$(sed -n 1p $f)"
name="$(sed -n 2p $f)"
date="$(sed -n 3p $f)"
subject="$(sed -n 4p $f)"
tag="$(sed -n 5p $f)"

git config user.name "$name"
git config user.email "$email"
git add $(find . -type f)
( echo "$subject"; sed -n '/^$/,$p' $f ) \
  | git commit --allow-empty -F- --date "$date"
git tag -a -m 'Generated tag reflecting release on Usenet' "$tag"
