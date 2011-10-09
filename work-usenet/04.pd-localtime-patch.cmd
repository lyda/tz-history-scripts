#!/bin/bash

patch -d . < ../04.pd-localtime-patch
../checkin.sh ../04.pd-localtime-patch.meta
