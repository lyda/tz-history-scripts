#!/bin/bash

rm asia australasia etcetera europe EXPLANATION Makefile mkdir.c
rm northamerica pacificnew README scheck.c settz.3 settz.c strchr.c
rm tzcomp.8 tzcomp.c tzdump.c tzfile.5 tzfile.h years.sh

unshar ../04.pd-localtime-part0*.shar
../checkin.sh ../04.pd-localtime-part01.shar.meta
