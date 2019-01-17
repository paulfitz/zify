#!/bin/bash

for f in $(cd materials/blendermada/downloads/; ls); do
  echo "==================================================================="
  echo "Working on $f"
  ./bin/change_material.sh \
    materials/blendermada/template.blend \
    materials/blendermada/downloads/$f \
    design/blendermada/$f
done
