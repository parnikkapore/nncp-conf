# Generates quux entries

# depcheck
redo-ifchange "entries-quux.ls"

# Make a temp directory for the json files
jsons="$(mktemp -d)"
_pwd="${PWD}"
export jsons _pwd

cd "../entries-quux" || exit 123

# convert
for f in *; do
    hjson-cli -j "${f}" > "${jsons}/$(basename -a "$f")"
done

# and go
cd "${jsons}" || exit 124
jq '{(input_filename): (. + if input_filename == "quux"
                              then {}
                              else {via: ["quux"]}
                            end)
    }' -- * \
    | jq -s 'reduce .[] as $a ({}; . * $a)' \
    > "${_pwd}"/"$3"

# cleanup
rm -r "${jsons}"
