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
  # Note the following rm commands assume the tarballs are all sane
  # and don't contain sub-directories.  It does not hurt to check all
  # the tarballs first:
  #   for f in tarballs/*.tar; do tar tf $f; done | sort -u
  case "$f" in
    tzcode*)
      rm -f $old_tzcode
      old_tzcode="$(tar tf ../tarballs/$f)"
      mkfile=mktzcode.sh
      ;;
    tzdata*)
      rm -f $old_tzcode
      old_tzcode="$(tar tf ../tarballs/$f)"
      mkfile=mktzdata.sh
      ;;
  esac

  # Remove existing $mkfile.
  if [[ -f $mkfile ]]; then
    git config --unset user.name
    git config --unset user.email
    git rm $mkfile
    git commit -m "Removing $mkfile for new version."
  fi

  # Add the new version.
  tar xf ../tarballs/$f
  git config user.name "$name"
  git config user.email "$email"
  git add $(find . -type f | fgrep -v .git)
  ( echo "$subject"; sed -n '/^$/,$p' ../meta/$f.meta; echo "$msgid" ) \
    | git commit --allow-empty -F- --date "$date"
  # TODO: annotated tag?
  git tag -a -m 'Generated tag reflecting release on elsie' ${f%.tar}

  # Make and checkin script to build tarball.
  cat > $mkfile << EOF
#!/bin/bash

tar zcf $f.gz $(echo $old_tzcode)
EOF
  chmod 755 $mkfile
  git config --unset user.name
  git config --unset user.email
  git add $mkfile
  git commit -m "Script to build $f.gz"
  git tag -a -m "Script to build $f.gz" $f.gz

done
