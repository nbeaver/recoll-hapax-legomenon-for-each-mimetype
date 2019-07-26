#! /usr/bin/env bash
if ! test -f "$*"
then
    printf 'Usage: %s /path/to/file\n' "$0"
fi
filename="$*"
recoll -t "$(< $filename)"
