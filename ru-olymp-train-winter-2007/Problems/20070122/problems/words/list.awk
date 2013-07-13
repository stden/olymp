#!/bin/gawk
BEGIN {
 n = 0; s = 0; printf "Test\tScore\n"
}
{
 n++; num[n] = $1; score[n] = $6; s += score[n];
 printf "%4s\t%3d\n", num[n], score[n];
}
END {
 printf "Total score: %d\n", s;
}
