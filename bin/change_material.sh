#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$DIR/utils.sh"
set -e

if [[ -z "$3" ]]; then
    echo "call as ./thing.sh in.blend material.blend out.blend"
    exit 1
fi

dir="$4"
if [[ -z "$dir" ]]; then
    dir=$(mktemp -d)
    trap "rm -rf '$dir'" EXIT
fi

blend_in="$1"
blend_mat="$2"
blend_out="$3"

if [ ! -e "$blend_in" ]; then
    echo "missing blend file '$blend_in'"
    exit 1
fi

if [ ! -e "$blend_mat" ]; then
    echo "missing blend file '$blend_mat'"
    exit 1
fi

base=$PWD
rblend_in=$(realpath "$blend_in")
rblend_mat=$(realpath "$blend_mat")

echo "Working in $dir"
cd $dir

blpy="bl.py"
blend="make.blend"

{
cat<<EOF
import bpy
with bpy.data.libraries.load("$rblend_mat") as (data_in, data_out):
  materials = data_in.materials
material = materials[0]
dir = "$rblend_mat\\\\Material\\\\"
bpy.ops.wm.append(filepath=dir, filename=material, directory=dir, link=False)
bpy.data.objects['Text'].data.materials[0] = bpy.data.materials.get(material)
bpy.ops.wm.save_mainfile(filepath="$blend", check_existing=False)
EOF
} > $blpy

blender="blender"

run "$blender -b $rblend_in -P $blpy"

cd $base
cp $dir/$blend $blend_out
echo "Saved to $blend_out"

