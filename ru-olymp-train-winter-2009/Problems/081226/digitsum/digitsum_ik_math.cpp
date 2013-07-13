#include <cmath>
#include <cstdio>

#define TASKNAME "digitsum"

typedef long double real;

int fun (int k)
{
 return int (floorl (sqrtl (real ((2.0 * k) * k))));
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
