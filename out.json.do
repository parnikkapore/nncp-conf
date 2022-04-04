# For finally merging everything together

FILES='nncp.json neigh/neigh.json'

# recurse first
redo-ifchange $FILES

# and merge
jq -s 'reduce .[] as $a ({}; . * $a)' $FILES > $3;
