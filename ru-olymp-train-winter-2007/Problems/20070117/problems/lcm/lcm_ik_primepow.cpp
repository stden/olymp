#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <algorithm>

#define TASKNAME "lcm"
using namespace std;
typedef double real;

const int MaxD = 121, Base = 10000, LogBase = 4;
typedef int bignum [MaxD + 1];

bignum res;

void multc (bignum & a, const bignum & b, const int c)
{
 int i, p;
 p = 0;
 for (i = 1; i <= b[0]; i++)
 {
  p += b[i] * c;
  a[i] = p % Base;
  p /= Base;
 }
 while (p > 0)
 {
  a[i] = p % Base;
  p /= Base;
  i++;
 }
 while (i > 0 && a[i] == 0) i--;
 a[0] = i;
}

void outbln (const bignum & a)
{
 int i;
 printf ("%d", a[a[0]]);
 for (i = a[0] - 1; i >= 1; i--)
  printf ("%0*d", LogBase, a[i]);
 printf ("\n");
}

const int MaxN = 1000, MaxP = 168, MaxL = 10;

int p [MaxP];
int q [MaxN + 1];
bool b [MaxN + 1];
int ind [MaxN + 1] [MaxL], deg [MaxN + 1] [MaxL];
int len [MaxN + 1];
int u [MaxP];
int n, k;

void init (void)
{
 int i, j, k, l;
 l = 0;
 for (i = 2; i <= MaxN; i++)
 {
  for (j = 0; j < l; j++)
   if (!(i % p[j]))
    break;
  if (j == l)
   p[l++] = i;
 }
 assert (l == MaxP);
 for (i = 1; i <= MaxN; i++)
 {
  k = i;
  l = 0;
  for (j = 0; j < MaxP; j++)
   if (!(k % p[j]))
   {
    ind[i][l] = j;
    deg[i][l] = 0;
    while (!(k % p[j]))
    {
     k /= p[j];
     deg[i][l]++;
    }
    l++;
   }
  len[i] = l;
 }
}

int main (void)
{
 int i, j, l, r, s;
 real max, cur, temp;
 int arg;
 init ();
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 while (scanf (" %d %d", &n, &k) != EOF)
 {
  memset (u, 0, sizeof (u));
  memset (b, 0, sizeof (b));
  cur = 1.0;
  for (i = 0; i < k; i++)
  {
   max = 0.0; arg = 0;
   for (j = 1; j <= n; j++) if ((len[j] == 1 || arg == 0) && !b[j])
   {
    temp = 1.0;
    for (l = len[j] - 1; l >= 0; l--)
    {
     r = ind[j][l];
     s = u[r];
     while (s < deg[j][l])
     {
      temp *= p[r];
      s++;
     }
    }
    if (max < temp)
    {
     max = temp;
     arg = j;
    }
   }

   b[arg] = true;
   for (l = len[arg] - 1; l >= 0; l--)
   {
    r = ind[arg][l];
    while (u[r] < deg[arg][l])
    {
     cur *= p[r];
     u[r]++;
    }
   }
  }

  memset (res, 0, sizeof (res));
  res[0] = res[1] = 1;
  for (i = 0; i < MaxP; i++)
   for (j = 0; j < u[i]; j++)
    multc (res, res, p[i]);
  outbln (res);

  l = 0;
  for (i = 1; i <= n; i++) if (b[i])
   q[l++] = i;
  assert (l == k);
  for (i = 0; i < k; i++)
   printf ("%d%c", q[i], i + 1 < k ? ' ' : '\n');
 }
 return 0;
}
