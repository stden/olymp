#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <algorithm>

#define TASKNAME "lcm"
using namespace std;

typedef long long int64;
#define INT64 "%I64d"

const int MaxN = 1003;

int u [MaxN], v [MaxN];
int64 res;
int n, k, len;

int gcd (int64 a, int64 b)
{
 int64 t;
 while (b > 0)
 {
  t = a % b;
  a = b;
  b = t;
 }
 return a;
}

void recur (int m, int l, int64 cur)
{
 int j;
 int64 temp;
 if (res < cur)
 {
  res = cur;
  len = k - l;
  for (j = 0; j < k - l; j++)
   v[j] = u[j];
 }
 if (l == 0) return;
 for (j = m; j >= l; j--)
 {
  temp = gcd (cur, j);
  temp = (cur * j) / temp;
  u[k - l] = j;
  recur (j - 1, l - 1, temp);
 }
}

int main (void)
{
 int i, j;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 while (scanf (" %d %d", &n, &k) != EOF)
 {
  res = 0;
  len = 0;
  recur (n, k, 1);
  printf (INT64 "\n", res);
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
