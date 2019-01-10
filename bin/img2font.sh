#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$DIR/utils.sh"
set -e

if [[ -z "$2" ]]; then
    echo "call as ./img2font.sh in.png out.ttf"
    exit 1
fi

dir="$3"
if [[ -z "$dir" ]]; then
    dir=$(mktemp -d)
    trap "rm -rf '$dir'" EXIT
fi

img="$1"
font="$2"

if [ ! -e "$img" ]; then
    echo "missing image '$img'"
    exit 1
fi

base=$PWD
rimg=$(realpath "$img")
echo "Working in $dir"
cd $dir


hdr "Create greyscale image"

png="test.png"
rm -f $png

coopts="-trim -sample 120 -flatten -type Grayscale"
convert="convert"
run "$convert $rimg $coopts $png"
result=`bash -c "$cmd"`

if [ ! -e "$png" ]; then
    echo "cannot produce grayscale image"
    exit 1
fi

hdr "Trace font"

# fontforge

fontforge="fontforge"

ttf="font.ttf"
rm -f $ttf
ffff="ff.ff"
rm -f $ffff

{
cat<<EOF
New();
Select("A");
Import("$png");
SetPref("AutotraceArgs","$poopt");
AutoTrace();
Simplify(128+32+8,1.5);
ClearBackground();
AddExtrema();
cur_bbox = GlyphInfo("BBox");
w = Ceil(cur_bbox[2]-cur_bbox[0]);
h = Ceil(cur_bbox[3]-cur_bbox[1]);
mag = h;
if (w>h);
    mag = w;
endif;
Scale(100*1000/mag);
cur_bbox = GlyphInfo("BBox");
Move(-cur_bbox[0],-cur_bbox[1]);
cur_bbox = GlyphInfo("BBox");
w = Ceil(cur_bbox[2]-cur_bbox[0]);
h = Ceil(cur_bbox[3]-cur_bbox[1]);
Move((1000-w)/2,(1000-h)/2);
SetWidth(1000);
SetVWidth(1000);
Generate("$ttf");
Save("$ttf.sfd");
EOF
} >> $ffff

# install fontforge, potrace
run "$fontforge -script $ffff"

if [ ! -e $ttf ]; then
    echo "failed to generate font $ttf"
fi

hdr "Finalize"

cd $base
run "cp $dir/$ttf $font"
echo "Created $font"


