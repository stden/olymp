#include <cstdio>
#include <vector>
#include <algorithm>
#include <cmath>
#include <cstring>

using namespace std;

#define taskname "btrees"

long long cnt[2][600][600];
long long s[2][600];

int main () {
  freopen (taskname".in", "rt", stdin);
  freopen (taskname".out", "wt", stdout);
  int n, t;
  scanf ("%d%d", &n, &t);
  if (t - 1 > n) {
    printf ("0\n");
    return 0;
  }
  memset (cnt, 0, sizeof (cnt));
  int cur = t - 1;
  long long ans = 0;
  for (int l = 0; ; l++) {
    int ci = l % 2;
    int pi = 1 - ci;
    memset (cnt[ci], 0, sizeof (cnt[ci]));
    memset (s[ci], 0, sizeof (s[ci]));
    if (l == 0) {
      for (int i = t - 1; i < 2 * t; i++)
	cnt[ci][i][1] = 1;
      for (int i = t - 1; i < 2 * t; i++)
	s[ci][i] = 1;
    } else {
      cnt[ci][0][0] = 1;
      for (int i = 1; i <= n; i++)
	for (int j = 1; j <= 2 * t; j++)
	  for (int k = 1; k <= i; k++) 
	    cnt[ci][i][j] += cnt[ci][i - k][j - 1] * s[pi][k];
      for (int i = 1; i <= n; i++)
	for (int j = t; j <= 2 * t; j++)
	  s[ci][i] = s[ci][i] + cnt[ci][i][j];    
    }
    ans += s[ci][n];
    if (cur > n / t) break;
    cur *= t;
  }
  printf ("%lld\n", ans);
}