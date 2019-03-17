#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$DIR/utils.sh"
set -e

if [[ -z "$3" ]]; then
    echo "call as ./render.sh in.blend in.ttf out.png"
    exit 1
fi

dir="$4"
if [[ -z "$dir" ]]; then
    dir=$(mktemp -d)
    trap "rm -rf '$dir'" EXIT
fi

blend="$1"
font="$2"
oimg="$3"

if [ ! -e "$blend" ]; then
    echo "missing blend file '$blend'"
    exit 1
fi

if [ ! -e "$font" ]; then
    echo "missing font file '$font'"
    exit 1
fi

base=$PWD
rblend=$(realpath "$blend")
rfont=$(realpath "$font")

echo "Working in $dir"
cd $dir

blpy="bl.py"
blend="make.blend"
rm -f $blpy $blend 

{
res=100
homer="$PWD/output"
cat<<EOF
import bpy
import os
bpy.data.fonts.get("example.ttf").filepath = "$rfont"
bpy.data.fonts.get("example.ttf").pack()
context = bpy.context
context.scene.render.filepath = "$homer"
context.scene.frame_start = 1
context.scene.frame_end = 1
if os.environ.get('ZIFY_SCALE'):
    scale = context.scene.render.resolution_percentage
    scale = int(scale * int(os.environ.get('ZIFY_SCALE')) / 100.0 + 0.5)
    context.scene.render.resolution_percentage = scale
if os.environ.get('ZIFY_SAMPLES'):
    samples = int(os.environ.get('ZIFY_SAMPLES'))
    if samples == 0:
       samples = bpy.data.scenes["Scene"].cycles.preview_samples
    bpy.data.scenes["Scene"].cycles.samples = samples
if os.environ.get('ZIFY_DENOISING'):
   bpy.data.scenes["Scene"].render.layers[0].cycles.use_denoising = True
if os.environ.get('ZIFY_MAX_BOUNCES'):
   bpy.data.scenes["Scene"].cycles.max_bounces = int(os.environ['ZIFY_MAX_BOUNCES'])
if os.environ.get('ZIFY_MIN_BOUNCES'):
   bpy.data.scenes["Scene"].cycles.min_bounces = int(os.environ['ZIFY_MIN_BOUNCES'])
print("Scale:", context.scene.render.resolution_percentage)
print("Samples:", bpy.data.scenes["Scene"].cycles.samples)
bpy.ops.render.render(animation=True)
bpy.ops.wm.save_mainfile(filepath="$blend", check_existing=False)
EOF
} > $blpy

blender="blender"

run "$blender -b $rblend -P $blpy"

cd $base
convert "$dir/output0001.*" -trim $oimg
echo "Saved to $oimg"

