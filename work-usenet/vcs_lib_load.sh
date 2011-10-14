#!/bin/bash

if [[ ! -f $VCS_LIB ]]; then
  echo "The $VCS VCS is not yet supported."
  exit 1
fi

. $VCS_LIB
