#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$DIR/bin/utils.sh"
set -e

if [[ -z "$3" ]]; then
    echo "call as ./apply.sh in.blend in.png out.png"
    exit 1
fi

dir="$4"
if [[ -z "$dir" ]]; then
    dir=$(mktemp -d)
    trap "rm -rf '$dir'" EXIT
fi

blend="$1"
img_in="$2"
img_out="$3"

"$DIR/bin/img2font.sh" "$img_in" "$dir/tmp.ttf" "$dir"
"$DIR/bin/render.sh" "$blend" "$dir/tmp.ttf" "$img_out" "$dir"
