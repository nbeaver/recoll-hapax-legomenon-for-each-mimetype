#! /usr/bin/env gnuplot
set terminal pngcairo
set xlabel "Time [s]"
set ylabel "Distance [m]"
myvar = "${unique_word}"
print "myvar = ", myvar
