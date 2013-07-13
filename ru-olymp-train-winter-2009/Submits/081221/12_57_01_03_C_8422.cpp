#include <cstdio>
#include <iostream>
#include <cstring>
#include <cmath>

using namespace std;

long long s[100100];
int a[100100];
long long best[2250][2250];
int prev[2250][2250];

int out (int i, int j, string cur) {
   if (i == j) cout << cur << endl; else {
      out (i, prev[i][j], cur + '0');
      out (prev[i][j] + 1, j, cur + '1');
   }
   return 0;
}

int main () {
  freopen ("code.in", "rt", stdin);
  freopen ("code.ans", "wt", stdout);
  int n;
  scanf ("%d", &n);
  s[0] = 0;
  for (int i = 1; i <= n; i++) {
    scanf ("%d", &a[i]);
    s[i] = s[i - 1] + a[i];
  }
  for (int l = 0; l < n; l++)
    for (int i = 1; i + l <= n; i++) {
      int j = i + l;
      best[i][j] = -1;
      if (!l) {
	best[i][j] = 0;
        prev[i][j] = i - 1;
	continue;
      }
      long long tmp = s[j] - s[i - 1];
      for (int k = max (i, prev[i][j - 1]); k <= prev[i + 1][j]; k++) {
	if (best[i][j] == -1 || tmp + best[i][k] + best[k + 1][j] < best[i][j]) {
	  best[i][j] = tmp + best[i][k] + best[k + 1][j];
	  prev[i][j] = k;
	}
      }
   }
  printf ("%lld\n", best[1][n]);
  if (n == 1) printf ("0\n"); else out (1, n, "");
}