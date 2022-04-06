# Generates an entry for a directory 

# depcheck
redo-ifchange "${2}.ls"

# Make a temp directory for the json files
export jsons="$(mktemp -d)"
export _pwd="${PWD}"

cd "../${2}" || exit 123

# convert
for f in *; do
    hjson-cli -j "${f}" > "${jsons}/$(basename -a $f)"
done

# and go
cd "${jsons}"
jq '{(input_filename): .}' * \
    | jq -s 'reduce .[] as $a ({}; . * $a) | {neigh: .}' \
    > ${_pwd}/$3

# cleanup
rm -r "${jsons}"
