# For finally merging everything together

# shellcheck disable=SC2086  # Yes, splitting by IFS is supposed to happen here

FILES='nncp.json neigh/neigh.json'

# recurse first
redo-ifchange $FILES

# and merge
jq -s 'reduce .[] as $a ({}; . * $a)' $FILES > $3;
