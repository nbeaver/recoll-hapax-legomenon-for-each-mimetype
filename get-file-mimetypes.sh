#! /usr/bin/env sh

if test "$#" -eq 0
then
    printf 'Usage: %s file1 file2 file3\n' "$0" >&2
    exit 1
fi

for file in "$@"
do
    printf '%s\t' "${file}"
    xdg-mime query filetype "${file}"
done
