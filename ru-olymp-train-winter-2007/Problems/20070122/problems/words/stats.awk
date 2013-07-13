#!/bin/gawk
BEGIN {n = 0}
/Test/ {n++; num[n] = $2; k[n] = $3; l[n] = $4;}
/Steps/ {st[n] = $3;}
/result/ {res[n] = $4;}
END {
 for (test = 1; test <= n; test++)
  printf "%s %02d %02d %18s %2d\n", num[test], k[test], l[test], st[test],
   res[test]
}
