# Merge all neighbour records together ========================================

# Setup
_pwd=$(pwd)

# fetch quux entries
redo-ifchange entries-quux

# Merge all records for each neighbour together
find . -type f -path './entries-*/*' -printf 'merged-entries/%f\n' | sort | uniq | xargs redo-ifchange

# Then stitch them together
cd merged-entries
mv default.do ../_merger.do # ugly hack
jq '{(input_filename): .}' * \
    | jq -s 'reduce .[] as $a ({}; . * $a) | {neigh: .}' \
    > ${_pwd}/$3
mv ../_merger.do default.do
