#!/bin/bash

export VCS=${1-git}
base_dir=$(readlink -f ${0%/*})
export VCS_LIB=${base_dir%/*}/$VCS/vcs_lib.sh
export VCS_LIB_LOAD=${base_dir%}/vcs_lib_load.sh
. $VCS_LIB_LOAD

mkdir $VCS.settz || exit
cd $VCS.settz || exit

for cmd in ../*.cmd; do
  echo $cmd
  $cmd
done
