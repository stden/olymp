#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <algorithm>
#include <string>
#include <vector>

#define TASKNAME "republic"

using namespace std;

const int MinN = 1, MaxN = 100000;

int b [MaxN], e [MaxN], u [MaxN], v [MaxN];

int main (void)
{
 int i, j, k, l, m, n;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 while (scanf (" %d %d", &n, &m) != EOF)
 {
  assert (n >= MinN && n <= MaxN);
  assert (m >= MinN && m <= MaxN);
  memset (u, 0, sizeof (u));
  memset (v, 0, sizeof (v));
  for (i = 0; i < m; i++)
  {
   scanf (" %d %d", &b[i], &e[i]);
   b[i]--; e[i]--;
   u[b[i]]++; v[e[i]]++;
  }
  vector <int> p, q;
  for (i = 0; i < n; i++)
   if (u[i] == 0) p.push_back (i);
  for (i = 0; i < n; i++)
   if (v[i] == 0) q.push_back (i);
  reverse (q.begin (), q.end ());
  random_shuffle (p.begin(), p.end());
  random_shuffle (q.begin(), q.end());
  l = (p.size () > q.size ()) ? p.size () : q.size ();
  printf ("%d\n", l);
  i = 0;
  j = 0;
  for (k = 0; k < l; k++)
  {
   printf ("%d %d\n", p[i] + 1, q[j] + 1);
   i++; if (i == (int) p.size ()) i = 0;
   j++; if (j == (int) q.size ()) j = 0;
  }
 }
}
