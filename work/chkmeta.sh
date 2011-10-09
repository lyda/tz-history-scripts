#!/bin/bash

line=$1
if [[ $line < 1 || $line > 6 ]]; then
  echo The first arg must be between 1 and 6.  It was "'$line'".
  exit
fi
for f in $(cat index); do
  echo ${f}: "$(sed -n ${line}p meta/$f.meta)"
done
