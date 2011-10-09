#!/bin/bash

rm asctime.c asia australasia ctime.c dysize.c etcetera europe
rm EXPLANATION ialloc.c localtime.c Makefile mkdir.c newctime.3
rm northamerica pacificnew Patchlevel.h README scheck.c settz.3
rm settz.c solar87 strchr.c systemv Theory timemk.c tzcomp.8
rm tzcomp.c tzdump.c tzfile.5 tzfile.h years.sh zdump.8 zdump.c
rm zic.8 zic.c

unshar ../05.localtime3-part0[123].shar
../checkin.sh ../05.localtime3-part01.shar.meta
