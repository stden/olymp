#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <algorithm>

#define TASKNAME "lcm"
using namespace std;

const int MaxN = 1003, MaxD = 10, Base = 10000, LogBase = 4;
typedef int bignum [MaxD + 1];

int u [MaxN], v [MaxN];
bignum curs [MaxN];
bignum res;
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

int divc (bignum & a, const bignum & b, const int c)
{
 int i, p;
 p = 0;
 a[0] = b[0];
 for (i = b[0]; i >= 1; i--)
 {
  p = p * Base + b[i];
  a[i] = p / c;
  p %= c;
 }
 while (a[0] > 0 && a[a[0]] == 0) a[0]--;
 return p;
}

void outbln (const bignum & a)
{
 int i;
 printf ("%d", a[a[0]]);
 for (i = a[0] - 1; i >= 1; i--)
  printf ("%0*d", LogBase, a[i]);
 printf ("\n");
}

int gcd (const bignum & a, int b)
{
 int c, t;
 bignum t1;
 c = divc (t1, a, b);
 while (c > 0)
 {
  t = b % c;
  b = c;
  c = t;
 }
 return b;
}

void recur (int m, int l)
{
 bignum & cur = curs[l];
 int j, t;
 if (less (res, cur))
 {
  assignb (res, cur);
  len = k - l;
  for (j = 0; j < k - l; j++)
   v[j] = u[j];
 }
 if (l == 0) return;
 bignum & next = curs[l - 1];
 for (j = m; j >= l; j--)
 {
  t = gcd (cur, j);
  clearb (next);
  multc (next, cur, j);
  divc (next, next, t);
  u[k - l] = j;
  recur (j - 1, l - 1);
 }
}

int main (void)
{
 int i, j;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 while (scanf (" %d %d", &n, &k) != EOF)
 {
  memset (res, 0, sizeof (res));
  memset (curs, 0, sizeof (curs));
  curs[k][0] = curs[k][1] = 1;
  len = 0;
  recur (n, k);
  outbln (res);
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
