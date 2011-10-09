#!/bin/bash

for f in $(cat index); do
  sed -i '3s/EDT$/-0400/;3s/EST/-0500/;3s/ (E[SD]T)$//' meta/$f.meta
done
