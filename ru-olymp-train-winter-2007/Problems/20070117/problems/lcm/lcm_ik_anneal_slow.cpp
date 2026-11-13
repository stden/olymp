#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <algorithm>

#define TASKNAME "lcm"
using namespace std;
typedef long double real;

const int MaxD = 121, Base = 10000, LogBase = 4;
const real TMin = 0.05, TMax = 2.5, TMult = 0.999999;
const int MaxC = 65536, MaxStep = 10;
const real MinC = 1.0 / MaxC, eps = 1E-12;
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
bool b [MaxN + 1];
int ind [MaxN + 1] [MaxL], deg [MaxN + 1] [MaxL];
int len [MaxN + 1];
int u [MaxP], v [MaxP], w [MaxP];
int q [MaxN + 1], d [MaxN + 1];
real ans, cur, next;
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

real calc (void)
{
 real res;
 int i, j, l, r;
 res = 1.0;
 memset (v, 0, sizeof (v));
 for (i = 0; i < k; i++)
 {
  j = q[i];
  for (l = len[j] - 1; l >= 0; l--)
  {
   r = ind[j][l];
   while (v[r] < deg[j][l])
   {
    res *= p[r];
    v[r]++;
   }
  }
 }
 return res;
}

void checkmax (void)
{
 if (ans < cur)
 {
  ans = cur * (1.0 + eps);
  memmove (w, u, sizeof (u));
  memmove (d, q, sizeof (q));
 }
}

int main (void)
{
 int i, j, l, r, s;
 srand (12245);
 real max, temp, f, t;
 int arg, x, y, step;
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
   for (j = 1; j <= n; j++) if ((len[j] <= 2 || arg == 0) && !b[j])
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

  l = 0;
  for (i = 1; i <= n; i++) if (b[i])
   q[l++] = i;
  assert (l == k);
  ans = -1.0;
  checkmax ();

  if (k > 0 && k < n)
   for (step = 0; step < MaxStep; step++)
    for (t = TMax; t >= TMin; t *= TMult)
    {
//     printf ("%d\n", int (log10l (cur)));
     l = rand () % k;
     x = q[l];
     r = rand () % (n - k);
     y = 0;
     for (j = 0; j < r; j++)
      do {y++;} while (b[y]);
     q[l] = y;
     temp = calc ();
     f = (rand () % MaxC) * MinC;
     if (temp * t >= f * cur)
     {
      memmove (u, v, sizeof (u));
      cur = temp;
      b[x] = false;
      b[y] = true;
      checkmax ();
     }
     else
     {
      q[l] = x;
     }
    }

  memset (res, 0, sizeof (res));
  res[0] = res[1] = 1;
  for (i = 0; i < MaxP; i++)
   for (j = 0; j < w[i]; j++)
    multc (res, res, p[i]);
  outbln (res);

  sort (d, d + k);
  for (i = 0; i < k; i++)
   printf ("%d%c", d[i], i + 1 < k ? ' ' : '\n');
 }
 return 0;
}
