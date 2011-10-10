#!/bin/bash

ls tarballs \
  | sed 's/\(tz[0-9]*\)\([a-z]*\)\([0-9]*.*\).tar/\3 \2 \0/' \
  | sed 's/^9/199/' \
  | sed 's/1993 /1993a /' \
  | sort \
  | cut -d\  -f3 \
  > index

# Now we need to tweak things.
if [[ -f tarballs/tzdatabeta.tar ]]; then
  # Move tzdatabeta.tar to just before the 1995 tarballs.
  sed -i '/tzdatabeta.tar/d' index
  ed index << EOF
/tz.*95
-
a
tzdatabeta.tar   
.
w
q
EOF
fi
