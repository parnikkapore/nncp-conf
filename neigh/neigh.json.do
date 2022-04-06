# Merge all neighbour records together ========================================

# Setup
_pwd=$(pwd)

# fetch quux entries
redo-ifchange entries-quux

# Merge all records for each neighbour together
find . -type d -path './entries-*' -printf 'merged-entries/%f.json\0' | xargs -0 redo-ifchange

# Then stitch them together
cd merged-entries
jq '{(input_filename): .}' *.json \
    | jq -s 'reduce .[] as $a ({}; . * $a) | {neigh: .}' \
    > ${_pwd}/$3
