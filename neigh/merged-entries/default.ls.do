# Virtual rule for a directory listing

cd "../${2}" || exit 123

redo-always
ls -lgG | redo-stamp
