#! /usr/bin/env bash
if test $# -eq 0
then
    printf 'Usage: %s /path/to/hapax_legomenon.txt\n' "$0"
fi
for filepath in "$@"
do
    while read line
    do
        recoll -t "${line}"
    done < ${filepath}
done
