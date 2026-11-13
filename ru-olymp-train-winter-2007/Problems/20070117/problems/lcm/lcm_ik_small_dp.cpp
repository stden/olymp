#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <algorithm>

#define TASKNAME "lcm"
using namespace std;

const int MaxN = 60, MaxD = 10, Base = 10000, LogBase = 4, MinC = 6;
const int MaxK = 22, MaxL = 1 << MaxK, MaxP = 17;
const int p [MaxP] =
 {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59};
const int s [MaxP] =
 {0, 3, 5, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21};
const int a [MaxP] =
 {7, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
const int mult [MaxK] = {2, 4, 16, 3, 9, 5, 25, 7, 49,
 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59};
typedef int bignum [MaxD + 1];

int q [MaxN + 1], v [MaxN];
char f [MaxL], g [MaxL];
int r [MaxL];
int n, k, len;

bool less (const bignum & a, const bignum & b)
{
 int i;
 if (a[0] < b[0]) return true;
 if (a[0] > b[0]) return false;
 for (i = a[0]; i >= 1; i--)
 {
  if (a[i] < b[i]) return true;
  if (a[i] > b[i]) return false;
 }
 return false;
}

void clearb (bignum & a)
{
 memset (a, 0, sizeof (int) * (a[0] + 1));
}

void assignb (bignum & a, const bignum & b)
{
 clearb (a);
 memmove (a, b, sizeof (int) * (b[0] + 1));
}

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

inline void fun (int x, bignum & ans)
{
 int i;
 clearb (ans);
 ans[0] = ans[1] = 1;
 for (i = 0; i < MaxK; i++)
  if ((x >> i) & 1)
   multc (ans, ans, mult[i]);
}

inline int maxadd (int a, int b)
{
 int m;
 m = a | b;
 m >>= 9;
 m = (m << 2) + max ((a >> 7) & 3, (b >> 7) & 3);
 m = (m << 2) + max ((a >> 5) & 3, (b >> 5) & 3);
 m = (m << 2) + max ((a >> 3) & 3, (b >> 3) & 3);
 m = (m << 3) + max (a & 7, b & 7);
 return m;
}

int main (void)
{
 bignum res, cur;
 int i, j, l, m;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 for (j = 1; j <= MaxN; j++)
 {
  i = j;
  m = 0;
  for (l = 0; l < MaxP; l++)
   while (!(i % p[l]))
   {
    i /= p[l];
    m += 1 << s[l];
   }
  q[j] = m;
 }
 while (scanf (" %d %d", &n, &k) != EOF)
 {
  memset (f, 127, sizeof (f));
  f[0] = 0;
  for (i = 0; i < MaxL; i++)
   for (j = 1; j <= n; j++)
   {
    m = maxadd (i, q[j]);
    if (f[m] > f[i] + 1)
    {
     f[m] = f[i] + 1;
     g[m] = j;
     r[m] = i;
    }
   }
  memset (res, 0, sizeof (res));
  memset (cur, 0, sizeof (cur));
  j = 0;
  for (i = 0; i < MaxL; i++)
   if (f[i] <= k)
   {
    fun (i, cur);
    if (less (res, cur))
    {
     assignb (res, cur);
     j = i;
    }
   }
  outbln (res);
  memset (v, 0, sizeof (v));
  len = 0;
  while (j > 0)
  {
   v[len++] = g[j];
   j = r[j];
  }
  for (i = 1; i <= n; i++)
  {
   if (len == k) break;
   for (j = 0; j < len; j++)
    if (v[j] == i)
     break;
   if (j == len)
    v[len++] = i;
  }
  sort (v, v + k);
  for (i = 0; i < len; i++)
   printf ("%d%c", v[i], i + 1 < len ? ' ' : '\n');
 }
 return 0;
}
