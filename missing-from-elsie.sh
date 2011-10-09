#!/bin/bash

( ls elsie;
  ls elsie;
  cat tarballs-in-tzarchive.txt;
  cat missing-bogus.txt ) \
  | sort \
  | uniq -u \
  > missing.txt
