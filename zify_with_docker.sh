#!/bin/bash

min_realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
set -e

if [[ -z "$3" ]]; then
    echo "call as ./zify.sh in.blend in.png out.png"
    exit 1
fi

blend=$(min_realpath "$1")
img_in=$(min_realpath "$2")
img_out="$3"

args=""
if [[ -n "$UID" && -n "$USER" ]]; then
    # run docker as current user for convenience
    args="-u=$UID:$(id -g $USER)"
fi

dblend=$(dirname "$blend")
dimg_in=$(dirname "$img_in")
dimg_out=$(min_realpath $(dirname "$img_out"))

fblend=$(basename "$blend")
fimg_in=$(basename "$img_in")
fimg_out=$(basename "$img_out")

cmd="docker run -it --rm $args -v $PWD:/app --env HOME=/app \
 -v $dblend:/blend -v $dimg_in:/img_in -v $dimg_out:/img_out \
 --env ZIFY_SCALE=$ZIFY_SCALE \
 --env ZIFY_SAMPLES=$ZIFY_SAMPLES \
 paulfitz/zify ./zify.sh /blend/$fblend /img_in/$fimg_in /img_out/$fimg_out"
echo $cmd
$cmd

echo /img_out/$fimg_out is $img_out
