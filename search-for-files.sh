#! /usr/bin/env bash
if ! test -f "$*"
then
    printf 'Usage: %s /path/to/hapax_legomenon.txt\n' "$0"
fi
filename="$*"
while read line; do
    recoll -t "${line}"
done < ${filename}
