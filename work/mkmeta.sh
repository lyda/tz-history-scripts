#!/bin/bash

if [[ ! -d meta ]]; then
  mkdir meta
fi
for f in $(cat index); do
  mboxgrep $f ../list/tzarchive-to-october-2011 \
    | sed 1d \
    | sed 's/^From: \(ado|olsona|OLSONA\).*/ado@elsie.nci.nih.gov\nArthur David Olson/' \
    | sed 's/^Subject: //' \
    | sed 's/^Date: //' \
    > meta/$f.meta
done

cat << EOF
Now the files in meta/ must be hand edited to remove duplacate messages.
The easiest way to do this is:

  1) First look for empty files: ls -lS meta
  2) Then $EDITOR $(grep -L 'From ' meta/*)
  3) Then run your eye over all the files to make sure they follow the
     correct format.

The meta files are of the following format:

  email address on line 1
  name on line 2
  date on line 3 (this format: Tue, 18 Jan 2000 09:33:46 -0500)
  subject on line 3 (used as the first line of the commit)
  msgid on line 5

  Everything else from ^$,$ (to use sed syntax) is copied into the
  commit message.
EOF
