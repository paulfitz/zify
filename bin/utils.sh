hdr() {
    printf '=%.0s' {1..70}
    echo ""
    echo "= $1"
}

run() {
    cmd="$1"
    echo "= > $cmd"
    bash -c "$cmd"
}

require() {
    cmd="$1"
    ex="$2"
    which "$cmd" || {
        echo "$cmd$ex is required, please install it" 1>&2
        exit 1
    } > /dev/null
}

check_requirements() {
    require "blender"
    require "realpath"
    require "convert" " (imagemagick)"
    require "fontforge"
}

if [[ -z "$R2D3D_CHECKED" ]]; then
    check_requirements
    export R2D3D_CHECKED=1
fi


