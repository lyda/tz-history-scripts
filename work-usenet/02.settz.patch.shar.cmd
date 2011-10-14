#!/bin/bash

. $VCS_LIB_LOAD

rm northamerica pacificnew
vcs_rm northamerica pacificnew
unshar ../02.settz.patch.shar
../checkin.sh ../02.settz.patch.shar.meta
