#!/bin/bash

rm northamerica
rm pacificnew
unshar ../02.settz.patch.shar
../checkin.sh ../02.settz.patch.shar.meta
