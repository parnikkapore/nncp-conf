# Virtual rule for a directory listing
# shellcheck shell=sh

cd "../${2}" || exit 123

redo-always
find . -maxdepth 1 -printf '%y\t%C@\t%p\n' | redo-stamp
