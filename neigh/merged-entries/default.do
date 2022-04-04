# Generate a combined node entry from multiple locations

# Setup
export curjson=$(tempfile)
export mergebuf=$(tempfile)
export writebuf="${PWD}/$3"

# Depcheck the files
find .. -type f -path "../entries-*/${1}" -print0 | xargs -0 redo-ifchange

# Process the files
echo '{}' > ${writebuf}
find .. -type f -path "../entries-*/${1}" -print0 |
xargs -0 -L 1 -I FILE bash -c "
    hjson-cli -j \"FILE\" > \"${curjson}\"
    jq -s 'reduce .[] as \$a ({}; . * \$a)' ${writebuf} ${curjson} > ${mergebuf}
    cp ${mergebuf} ${writebuf}
"

# Cleanup
rm "$curjson"
rm "$mergebuf"
