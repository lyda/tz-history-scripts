#!/bin/bash

. ./${0%/*}/vcs_lib_load.sh

f="$1"
email="$(sed -n 1p $f)"
name="$(sed -n 2p $f)"
date="$(sed -n 3p $f)"
subject="$(sed -n 4p $f)"
tag="$(sed -n 5p $f)"

commit_text=$(mktemp)
( echo "$subject"; sed -n '/^$/,$p' $f ) > $commit_text

vcs_commit "$name" "$email" "$date" $commit_text *
rm -f $commit_text
vcs_tag "$name" "$email" "$date" "$tag" \
        "Generated tag reflecting release on Usenet"
