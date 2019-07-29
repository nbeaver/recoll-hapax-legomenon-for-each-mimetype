#! /usr/bin/env bash

# TODO: replace this with a python script.

get_unique_word() 
{ 
    local unique_word=$(apg -n 1 -M L -m 30)
    # -n 1: generate just one
    # -M l: lowercase letters only
    # -m 30: minimum of 30 characters
    printf "${unique_word}"
    return 0
}

if ! test $# -eq 1
then
    printf "Usage: %s '/path/to/output/directory'\n" "%0"
    exit 1
fi
out_dir="$1"
base_filename=hapax_legomenon
hapax_list=${out_dir}/hapax_list.txt
# Truncate the list file.
truncate -s 0 ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/Makefile
.PHONY: ${unique_word}
${unique_word} :
	echo 'hello, world!'
EOF
printf "${unique_word}\n" >> ${hapax_list}
unique_word=$(get_unique_word)

cat << EOF > ${out_dir}/${base_filename}.desktop
[Desktop Entry]
Name=$unique_word
Type=Link
URL=file://
Icon=folder
EOF
printf "${unique_word}\n" >> ${hapax_list}

# TODO: decide if HTML is worth it or not.
#unique_word=$(get_unique_word)
#cat << EOF > ${out_dir}/${base_filename}.html
#<!DOCTYPE html>
#<html lang="en">
#  <head>
#    <meta charset="utf-8">
#    <title>$unique_word</title>
#    <link rel="stylesheet" href="style.css">
#    <script src="script.js"></script>
#  </head>
#  <body>
#    <p>Example HTML document.</p>
#  </body>
#</html>
#EOF
#printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.awk
{
text = ${unique_word}
print text
}
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.c
#include <stdio.h>
int main(int argc, char *argv[]) {
	printf("${unique_word}\n");
	return 0;
}
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.markdown
# An example Markdown document #

**${unique_word}**
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.mdown
# An example Markdown document #

**${unique_word}**
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.md
# An example Markdown document #

**${unique_word}**
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.pl
#!/usr/bin/env perl

use strict;
use warnings;

${unique_word} = "test";
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.py
#! /usr/bin/env python
from __future__ import print_function
if __name__ == '__main__':
    print("${unique_word}")
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.rst
===================================
An example reStucturedText document
===================================

**${unique_word}**
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.sh
#!/usr/bin/env sh
printf '%s\n' "${unique_word}"
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.tex
\documentclass{article}
\begin{document}
\LaTeX
\\${unique_word}
\end{document}
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.txt
${unique_word}
EOF
printf "${unique_word}\n" >> ${hapax_list}
