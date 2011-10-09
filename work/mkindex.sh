#!/bin/bash

ls tarballs \
  | sed 's/\(tz[0-9]*\)\([a-z]*\)\([0-9]*.*\).tar/\3 \2 \0/' \
  | sed 's/^9/199/' \
  | sed 's/1993 /1993a /' \
  | sort \
  | cut -d\  -f3 \
  > index
