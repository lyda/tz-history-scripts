#!/bin/bash

mkdir git.settz || exit
cd git.settz || exit

for cmd in ../*.cmd; do
  $cmd
done
