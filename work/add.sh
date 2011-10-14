#!/bin/bash



export VCS=${1-git}
base_dir=$(readlink -f ${0%/*})
export VCS_LIB=${base_dir%/*}/$VCS/vcs_lib.sh
export VCS_LIB_LOAD=${base_dir%}/vcs_lib_load.sh
. $VCS_LIB_LOAD

# These are the files which exist in ../work-usenet/$VCS.settz
old_tzcode="Theory usno1988 usno1989 README asctime.c date.1 date.c
            difftime.c emkdir.c getopt.c ialloc.c localtime.c logwtmp.c
            Makefile newctime.3 Patchlevel.h private.h scheck.c strftime.c
            tzfile.5 tzfile.h zdump.8 zdump.c zic.8 zic.c"
old_tzdata="africa antarctica asia australasia etcetera europe factory
            leapseconds northamerica pacificnew solar87 solar88 solar89
            southamerica systemv"

# Assumes $VCS.tz has already been created - probably from
# ../work-usenet/$VCS.settz
cd $VCS.tz || exit

rm_deleted() {
  local doomed=$(echo $* | tr ' ' '\n' | sort | uniq -u)
  if [[ -n "$doomed" ]]; then
    vcs_rm $doomed
  fi
}

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
      tzcode="$(tar tf ../tarballs/$f)"
      rm_deleted $tzcode $tzcode $old_tzcode
      old_tzcode="$tzcode"
      mkfile=mktzcode.sh
      ;;
    tzdata*)
      rm -f $old_tzdata
      tzdata="$(tar tf ../tarballs/$f)"
      rm_deleted $tzdata $tzdata $old_tzdata
      old_tzdata="$tzdata"
      mkfile=mktzdata.sh
      ;;
  esac

  # Add the new version.
  tar xf ../tarballs/$f
  commit_text=$(mktemp)
  ( echo "$subject"; sed -n '/^$/,$p' ../meta/$f.meta; echo "$msgid" ) \
    > "$commit_text"
  vcs_commit "$name" "$email" "$date" $commit_text *
  rm -f $commit_text
  vcs_tag "$name" "$email" "$date" "${f%.tar}" \
          "Generated tag reflecting release on elsie"

done
