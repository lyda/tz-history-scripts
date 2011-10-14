#!/bin/bash

. $VCS_LIB_LOAD

vcs_init
unshar ../01.settz.shar
../checkin.sh ../01.settz.shar.meta
