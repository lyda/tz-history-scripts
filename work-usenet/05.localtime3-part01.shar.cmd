#!/bin/bash

rm asctime.c asia australasia ctime.c dysize.c etcetera europe
rm ialloc.c localtime.c Makefile mkdir.c newctime.3
rm northamerica pacificnew Patchlevel.h README scheck.c
rm solar87 systemv Theory timemk.c
rm tzfile.5 tzfile.h zdump.8 zdump.c
rm zic.8 zic.c

git rm etcetera mkdir.c

unshar ../05.localtime3-part0[123].shar
../checkin.sh ../05.localtime3-part01.shar.meta
