#!/bin/bash

. $VCS_LIB_LOAD

rm asia australasia etcetera europe EXPLANATION Makefile mkdir.c
rm northamerica pacificnew README scheck.c settz.3 settz.c strchr.c
rm tzcomp.8 tzcomp.c tzdump.c tzfile.5 tzfile.h years.sh
vcs_rm EXPLANATION settz.3 settz.c strchr.c tzcomp.8 tzcomp.c tzdump.c years.sh

unshar ../04.pd-localtime-part0*.shar
../checkin.sh ../04.pd-localtime-part01.shar.meta
