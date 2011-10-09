#!/bin/bash

rm northamerica pacificnew
git rm northamerica pacificnew
unshar ../02.settz.patch.shar
../checkin.sh ../02.settz.patch.shar.meta
