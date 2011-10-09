#!/bin/bash

# These are the files as they exist in the ../work-usenet/git.settz
old_tzdata="africa antarctica asia australasia etcetera europe factory
            leapseconds northamerica pacificnew solar87 solar88 solar89
            southamerica systemv"
old_tzcode="Theory usno1988 usno1989 README asctime.c date.1 date.c
            difftime.c emkdir.c getopt.c ialloc.c localtime.c logwtmp.c
            Makefile newctime.3 Patchlevel.h private.h scheck.c strftime.c
            tzfile.5 tzfile.h zdump.8 zdump.c zic.8 zic.c"

# Assumes git.tz has already been created - probably from
# ../work-usenet/git.settz
cd git.tz || exit

for f in $(cat ../index); do
  email="$(sed -n 1p ../meta/$f.meta)"
  name="$(sed -n 2p ../meta/$f.meta)"
  date="$(sed -n 3p ../meta/$f.meta)"
  subject="$(sed -n 4p ../meta/$f.meta)"
  msgid="$(sed -n 5p ../meta/$f.meta)"
  case "$f" in
    tzcode*)
      rm $old_tzcode
      old_tzcode="$(tar tf ../tarballs/$f)"
      ;;
    tzdata*)
      rm $old_tzcode
      old_tzcode="$(tar tf ../tarballs/$f)"
      ;;
  esac
  tar xf ../tarballs/$f
  git config user.name "$name"
  git config user.email "$email"
  git add $(find . -type f | fgrep -v .git)
  ( echo "$subject"; sed -n '/^$/,$p' ../meta/$f.meta; echo "$msgid" ) \
    | git commit --allow-empty -F- --date "$date"
  # TODO: annotated tag?
  git tag -a -m 'Generated tag reflecting release on elsie' ${f%.tar}
done
