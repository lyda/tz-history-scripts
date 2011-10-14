#!/bin/bash

. $VCS_LIB_LOAD

rm africa antarctica asctime.c asia australasia ctime.c dysize.c
rm emkdir.c europe getopt.c ialloc.c leapseconds link.c localtime.c
rm Makefile Makefile.tc newctime.3 nonstd.h northamerica pacificnew
rm Patchlevel.h README scheck.c solar87 solar88 southamerica
rm stdio.h stdlib.h systemv Theory time.h timemk.c tzfile.5
rm tzfile.h zdump.8 zdump.c zic.8 zic.c

vcs_rm ctime.c dysize.c link.c Makefile.tc nonstd.h stdio.h stdlib.h
vcs_rm time.h timemk.c

unshar ../06.localtime3-part0*.shar
../checkin.sh ../06.localtime3-part01.shar.meta
