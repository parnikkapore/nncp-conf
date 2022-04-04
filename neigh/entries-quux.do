# For extracting node list from quux's list

source env.sh
nodetar="${quux_incoming}/quux-pub/nodelist.tar.gz"
nodetmp="$(tempfile -p 'ndlst')"

redo-ifchange "$nodetar"

rm "$nodetmp"
mkdir -p "$nodetmp"
tar --extract --gzip --file "$nodetar" --directory "$nodetmp"

rm -rf entries-quux
mv "${nodetmp}/nodelist/for-use" "${nodetmp}/nodelist/entries-quux"
cp -r "${nodetmp}/nodelist/entries-quux" .
# rm "entries-quux/quux"
rm "entries-quux/${this}"

rm -r "$nodetmp"