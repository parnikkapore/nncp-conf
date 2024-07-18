# Merge all neighbour records together ========================================

# Setup
_pwd=$(pwd)

# fetch quux entries
redo-ifchange entries-quux

# Merge all records for each neighbour together
find . -type d -path './entries-*' -printf 'merged-entries/%f.json\0' | xargs -0 redo-ifchange

# Then stitch them together
cd merged-entries || exit 123
jq -s 'reduce .[] as $a ({}; . * $a) | {neigh: .}' -- *.json \
    > "${_pwd}"/"$3"
