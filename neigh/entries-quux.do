# For extracting node list from quux's list
# shellcheck shell=sh

. ./env.sh
nodetar="${quux_incoming}/nodelist.tar.gz"
nodetmp="$(mktemp -d)"

redo-ifchange "$nodetar"

tar --extract --gzip --file "$nodetar" --directory "$nodetmp"

rm -rf entries-quux
mv "${nodetmp}/nodelist/for-use" "${nodetmp}/nodelist/entries-quux"
cp -r "${nodetmp}/nodelist/entries-quux" .
# rm "entries-quux/quux"
rm "entries-quux/${this}"

rm -r "$nodetmp"
