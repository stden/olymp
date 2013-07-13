#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "binsearch.h"

int D[61][2];

int min( int a, int b )
{
  if (a < b)
    return a;
  return b;
}

int max( int a, int b )
{
  if (a < b)
    return b;
  return a;
}

int my_query( int i )
{
  static int waslie = 0;
  int a, b;
  a = query(i);
  if (waslie)
   return a;
  b = query(i);
  if (a == b)
    return a;
  waslie = 1;
  return query(i);
}

int main( void )
{
  
  int i, l, r, c, n, res, a[2];
  for (i = 0; i <= 60; i++)
    D[i][0] = 10000;
  D[0][0] = 0;
  D[1][0] = 1;
  D[1][1] = 0;
  for (i = 2; i <= 60; i++)
    for (c = 0; c < i; c++)
      if (max(D[c][0], D[i - c - 1][0]) + 1 < D[i][0])
        D[i][0] = max(D[c][0], D[i - c - 1][0]) + 1, D[i][1] = c;
  
  n = getN();
  res = n + 1;
  l = 1, r = n;
  while (l <= r)
  {
    c = l + D[r - l + 1][1];
    if (my_query(c))
      res = c, r = c - 1;
    else
      l = c + 1;
  }
  answer(res);
  return 0;
}