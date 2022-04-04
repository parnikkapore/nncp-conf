# For merging config and saving it to the main config file

redo-ifchange out.json

# Copy to the correct location
hjson-cli out.json > ../nncp.hjson
