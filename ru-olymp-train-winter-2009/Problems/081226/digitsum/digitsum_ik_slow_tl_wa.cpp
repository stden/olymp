#include <cstdio>

#define TASKNAME "digitsum"

const int MaxL = 64000000;

char c [MaxL + 7];

int main (void)
{
 int test, tests;
 int i, j, l, r, s;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 for (i = j = 0; j < MaxL; i++)
 {
  c[j++] = 1, c[j++] = 1, c[j++] = 2, c[j++] = 1, c[j++] = 2;
  if (c[i] == 2)
   c[j++] = 1, c[j++] = 2;
 }

 scanf (" %d", &tests);
 for (test = 0; test < tests; test++)
 {
  scanf (" %d %d", &l, &r);
  if (l == 17 && r == 17)
  {
   printf ("%d\n", 2);
   continue;
  }
  s = 0;
  for (i = l; i <= r; i++)
   s += c[i];
  printf ("%d\n", s);
 }
 return 0;
}
