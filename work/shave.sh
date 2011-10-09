#!/bin/bash

cat meta/* | wc -l
for f in meta/*; do
  sed -i '/./,$!d' $f
  # This sucks, but the above sed command can leave a trailing line.
  while [[ -z "$(tail -1 $f)" ]]; do
    sed -i '$d' $f
  done
done
cat meta/* | wc -l
