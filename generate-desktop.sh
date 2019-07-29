#! /usr/bin/env bash

if ! test $# -eq 1
then
    printf "Usage: %s 'unique_word'\n" "%0"
    exit 1
fi
unique_word="$1"

cat << EOF
[Desktop Entry]
Name=$unique_word
Type=Link
URL=file://
Icon=folder
EOF
