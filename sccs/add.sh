#!/bin/bash

mkdir sccs.tz || exit
cd sccs.tz || exit
tar xf ../../elsie/tzdata2011l.tar.gz
tar xf ../../elsie/tzcode2011i.tar.gz
export PROJECTDIR=$PWD
make maintainer-clean
tz_files="$(echo *)"
mkdir SCCS || exit
skip='^strftime.3'
no_keyword_list="$( (
                      sed -n 's/.*@(#)\([^\t]*\)\t.*$/\1/p' $tz_files \
                        | egrep -v "$skip";
                      ls | grep -v SCCS
                    ) | sort | uniq -u)"
if [[ -n "$no_keyword_list" ]]; then
  echo "The following files are missing keywords: $no_keyword_list ."
  exit
fi
sed -n 's/.*@(#)\([^\t]*\)\t\([0-9\.]*\).*$/\1\/\2/p' $tz_files \
  | egrep -v "$skip" \
  | while read file_n_version; do
      file=${file_n_version%/*}
      version=${file_n_version#*/}
      sed -i '/Berkeley/!s/\(.*\)@(#)'$file'\t[0-9\.]*\(.*$\)/\1%W%\2/' $file
      sccs create -yinit -n -i -r$version $file < $file
    done
rm -f ,*
sccs get *
echo "Set PROJECTDIR: export PROJECTDIR=$PWD"
