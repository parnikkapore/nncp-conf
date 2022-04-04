# For generating .json files from .hjson files

original=$2.hjson
redo-ifchange $original
hjson-cli -j $original > $3
