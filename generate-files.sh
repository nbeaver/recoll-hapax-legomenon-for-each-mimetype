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
cat << EOF > ${out_dir}/AUTHORS
${unique_word}
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/COPYING
${unique_word}
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/INSTALL
${unique_word}
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/LICENSE
${unique_word}
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/README
${unique_word}
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.css
/* This is a comment.
   "${unique_word}" */
h1 {
    color: red;
}
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.csv
a,b,c
1,2,${unique_word}
4,5,6
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.desktop
[Desktop Entry]
Name=$unique_word
Type=Link
URL=file:///
Icon=folder
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.gnuplot
#! /usr/bin/env gnuplot
set terminal pngcairo
set xlabel "Time [s]"
set ylabel "Distance [m]"
myvar = "$unique_word"
print "myvar = ", myvar
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>$unique_word</title>
    <link rel="stylesheet" href="style.css">
    <script src="script.js"></script>
  </head>
  <body>
    <p>Example HTML document.</p>
  </body>
</html>
EOF
printf "${unique_word}\n" >> ${hapax_list}

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
cat << EOF > ${out_dir}/${base_filename}.ics
BEGIN:VCALENDAR
PRODID:-//ACME/DesktopCalendar//EN
VERSION:2.0
X-WR-RELCALID:12345
BEGIN:VEVENT
DTSTART:20101010T100000Z
DTEND:20101010T120000Z
CREATED:20101010T100000Z
UID:123456
SUMMARY: ${unique_word}
DESCRIPTION: This is an example description.
LOCATION: Example location.
END:VEVENT
END:VCALENDAR
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.js
// ${unique_word}
console.log("Hello world!")
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.json
{
  "key1" : "example value",
  "key2" : "${unique_word}"
}
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.log
${unique_word}
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.m
% An example MATLAB/Octave file.
A = [1 2;3 4];
e = eigs(A);
[V, D] = eig(A);
disp ${unique_word}
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
cat << EOF > ${out_dir}/${base_filename}.nb
(* Content-type: application/vnd.wolfram.mathematica *)
(*** Wolfram Notebook File ***)
(* http://www.wolfram.com/nb *)
(* Beginning of Notebook Content *)
Notebook[{
Cell[CellGroupData[{
Cell[BoxData[
 RowBox[{"${unique_word}", " ", "=", " ", "10"}]], "Input",
 CellChangeTimes->{{3.789322702668792*^9, 3.789322703547069*^9}},
 CellLabel->
  "In[160]:=",ExpressionUUID->"3622162c-c79a-4302-b53f-3d391de87942"],
Cell[BoxData["10"], "Output",
 CellChangeTimes->{3.789322704804154*^9},
 CellLabel->
  "Out[160]=",ExpressionUUID->"476d27b3-39d6-4bc9-a29b-4c9e2eb52ca8"]
}, Open  ]]
},
WindowSize->{956, 805},
WindowMargins->{{320, Automatic}, {0, Automatic}},
FrontEndVersion->"12.0 for Linux x86 (64-bit) (April 8, 2019)",
StyleDefinitions->"Default.nb"
]
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
cat << EOF > ${out_dir}/${base_filename}.ps
%!PS
/Sans
12 selectfont
100 500 moveto
(${unique_word}) show
showpage
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
cat << EOF > ${out_dir}/${base_filename}.tsv
a	b	c
1	2	${unique_word}
4	5	6
EOF
printf "${unique_word}\n" >> ${hapax_list}

unique_word=$(get_unique_word)
cat << EOF > ${out_dir}/${base_filename}.txt
${unique_word}
EOF
printf "${unique_word}\n" >> ${hapax_list}
