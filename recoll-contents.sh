#! /usr/bin/env bash
if ! test -f "$*"
then
    printf 'Usage: %s /path/to/file\n' "$0"
fi
filename="$*"
# Use command substitution instead of `cat`.
recoll -t "$(< $filename)"
