#!/bin/bash

sed '/^From /,/^$/d' list/tzarchive-to-october-2011 \
  | sed 's/[^Ta-z0-9.]\+/\n/g' \
  | tr T t \
  | grep '^tz' \
  | fgrep .tar \
  | grep '[0-9]' \
  | sed 's/\.$//'  \
  | grep -v '.tar$' \
  | sort -u \
  > tarballs-in-tzarchive.txt
