#! /usr/bin/env sh

for file in "$@"
do
    printf '%s\t' "${file}"
    xdg-mime query filetype "${file}"
done
