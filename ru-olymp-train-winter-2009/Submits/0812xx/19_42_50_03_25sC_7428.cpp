#include <cstdio>

using namespace std;

int sum[1 << 20];
int a[20];

int main () {
  freopen ("modsum.in", "rt", stdin);
  freopen ("modsum.out", "wt", stdout);
  int n;
  scanf ("%d", &n);
  int m = 1 << n;
  for (int i = 0; i < n; i++)
    scanf ("%d", &a[i]);
  for (int i = 0; i < m; i++) {
    int tmp = 0;
    for (int j = 0; j < n; j++)
      if ((i >> j) & 1) tmp += a[j];
    sum[i] = tmp;
  }
  long long ans = 0;
  for (int i = 1; i < m; i++)
    for (int j = (i + 1) | i; j < m; j = (j + 1) | i)
      ans += (sum[i] % sum[j - i]);
  printf ("%lld\n", ans);
}