#!/bin/bash

mkdir tarballs
cp ../elise/* tarballs/
cd tarballs
mv tzcode94d.tar.Z tzcode94d.tar
mv tzdata94d.tar.Z tzdata94d.tar
uncompress *.Z
gunzip *.gz

