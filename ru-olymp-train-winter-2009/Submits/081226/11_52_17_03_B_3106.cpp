#include <cstdio>

using namespace std;

int ans, amask;
int n, m;
int q[30];
int v[30][30];

int calc (int i, int mask, int a, int b, int c) {
//  printf ("%d %d %d %d %d\n", i, mask, a, b, c);
  if (i == n) {
    ans = c;
    amask = mask;
    return 0;
  }
  if (a < n / 2 && b < n / 2) {
    int s0 = 0;
    int s1 = 0;
    for (int j = 0; j < q[i]; j++)
      if ((mask >> v[i][j]) & 1) s1++; else s0++;
    if (c + s1 < ans) calc (i + 1, mask, a + 1, b, c + s1);
    if (c + s0 < ans) calc (i + 1, mask + (1 << i), a, b + 1, c + s0);
    return 0;
  }
  if (a < n / 2) {
    int s1 = 0;
    for (int j = 0; j < q[i]; j++)
      if ((mask >> v[i][j]) & 1) s1++;
    if (c + s1 < ans) calc (i + 1, mask, a + 1, b, c + s1);
    return 0;
  }
  int s0 = 0;
  for (int j = 0; j < q[i]; j++)
    if (((mask >> v[i][j]) & 1) == 0) s0++;
  if (c + s0 < ans) calc (i + 1, mask + (1 << i), a, b + 1, c + s0);
  return 0;
}   

int main () {
  freopen ("half.in", "rt", stdin);
  freopen ("half.out", "wt", stdout);
  scanf ("%d %d\n", &n, &m);
  for (int i = 0; i < m; i++) {
    int a, b;
    scanf ("%d%d", &a, &b); a--; b--;
    if (a < b) {
      v[b][q[b]] = a;
      q[b]++;
    } else {
      v[a][q[a]] = b;
      q[a]++;
    }
  }
  ans = m + 1;
  calc (1, 0, 1, 0, 0);
  for (int i = 0; i < n; i++)
    if (((amask >> i) & 1) == 0)
      printf ("%d ", i + 1);
  printf ("\n");
}