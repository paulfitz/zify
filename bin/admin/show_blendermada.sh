#!/bin/bash

for f in $(cd design/blendermada; ls *.blend); do
  name=$(basename $f .blend | sed "s|^blendermada-[0-9]*-||")
  echo $f $name
  mkdir -p out
  ./zify_with_docker.sh design/blendermada/$f input/frog.png out/$name.png
done
