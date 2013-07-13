#!/bin/gawk
BEGIN {n = 0;}
{n++; print $1, $2, n}
