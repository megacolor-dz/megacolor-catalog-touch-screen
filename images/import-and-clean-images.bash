#!/usr/bin/env bash

# clean
rm */*.jpg.original
rm */*.jpg
# import
for d in $(ls -d */); do cp ../spiver-all-images/$d/original/*.jpg $d; done;
# clean
for d in $(ls -d */); do for img in ${d}*.jpg; do grep -Fxq $img images-to-keep.txt || rm $img; done; done;
# rename
for d in $(ls -d */); do for img in ${d}*.jpg; do mv $img $img.original; done; done;
