#include <cstdio>

using namespace std;

int sum[1 << 20];
int a[20];
long long cnk[21][21];
int cnt[11];
long long ans;

int calc (int i, long long cur, int a, int b) {
  if (i > 10) {
    if (b != 0) {
      int tmp = a;
      if (tmp >= b) tmp %= b;
      ans += cur * tmp;
    }
    return 0;
  }
  if (cnt[i] == 0) calc (i + 1, cur, a, b); else {
    for (int l = 0; l <= cnt[i]; l++)
      for (int r = 0; r <= cnt[i] - l; r++)
	calc (i + 1, cur * cnk[cnt[i]][l] * cnk[cnt[i] - l][r], a + i * l, b + i * r);
  }
}

int main () {
  for (int i = 0; i <= 20; i++)
    for (int j = 0; j <= i; j++)
      if (i == 0 || j % i == 0) cnk[i][j] = 1; else cnk[i][j] = cnk[i - 1][j] + cnk[i - 1][j - 1];
  freopen ("modsum3.in", "rt", stdin);
  freopen ("modsum3.out", "wt", stdout);
  int n;
  scanf ("%d", &n);
  int m = 1 << n;
  for (int i = 0; i < n; i++) {
    scanf ("%d", &a[i]);
    cnt[a[i]]++;
  }
  ans = 0;
  calc (1, 1, 0, 0);
  printf ("%lld\n", ans);
}