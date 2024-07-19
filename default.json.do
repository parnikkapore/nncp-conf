# For generating .json files from .hjson files
# shellcheck shell=sh

original="$2".hjson
redo-ifchange "$original"
hjson-cli -j "$original" > "$3"
