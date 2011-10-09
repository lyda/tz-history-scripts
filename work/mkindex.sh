#!/bin/bash

ls tarballs \
  | sed 's/\(tz[0-9]*\)\([a-z]*\)\([0-9]*.*\).tar/\3 \2 \0/' \
  | sed 's/^9/199/' \
  | sort \
  | cut -d\  -f3 \
  > index
