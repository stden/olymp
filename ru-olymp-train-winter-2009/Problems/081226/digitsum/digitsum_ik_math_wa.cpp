#include <cmath>
#include <cstdio>

#define TASKNAME "digitsum"

typedef double real;
real c = sqrt (2.0);

int fun (int k)
{
 return int (floor (c * k));
}

int main (void)
{
 int test, tests;
 int l, r;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 scanf (" %d", &tests);
 for (test = 0; test < tests; test++)
 {
  scanf (" %d %d", &l, &r);
  printf ("%d\n", fun (r) - fun (l - 1));
 }
 return 0;
}
