#include <cstdio>
#include <vector>

using namespace std;

#define m 220

int n, a[m], s[m], u[m][m][m], p[m][m][m];

int main( void )
{
  freopen("change.in", "rt", stdin);
  freopen("change.out", "wt", stdout);
  scanf("%d", &n);
  for (int i = 0; i < n; i++)
    scanf("%d", &a[i]), s[i] = (i ? s[i - 1] : 0) + a[i];
  memset(u, 0, sizeof(u));
  fprintf(stderr, "0\n");
  u[0][0][0] = 1;
  for (int i = 0; i < n; i++)
    for (int j = 0; j < m; j++)
      for (int k = 0; k < m; k++)
        if (u[i][j][k])
        {
          u[i + 1][j][k] = 1, p[i + 1][j][k] = 0;
          u[i + 1][j + a[i]][k] = 1, p[i + 1][j + a[i]][k] = 1;
          u[i + 1][j][k + a[i]] = 1, p[i + 1][j][k + a[i]] = 2;
        }
  int be = -1, bj, bk;
  fprintf(stderr, "1\n");
  for (int j = 0; j < m; j++)
    for (int k = 0; k < m; k++)
      if (u[n][j][k])
        if (be == -1 ||
            (3 * j - s[n - 1]) * (3 * j - s[n - 1]) +
            (3 * k - s[n - 1]) * (3 * k - s[n - 1]) +
            (3 * (s[n - 1] - j - k) - s[n - 1]) * (3 * (s[n - 1] - j - k) - s[n - 1]) < be)
          be = (3 * j - s[n - 1]) * (3 * j - s[n - 1]) +
            (3 * k - s[n - 1]) * (3 * k - s[n - 1]) +
            (3 * (s[n - 1] - j - k) - s[n - 1]) * (3 * (s[n - 1] - j - k) - s[n - 1]), bj = j, bk = k;
  int i = n, j = bj, k = bk;
  vector <int> ans[3];
  fprintf(stderr, "2\n");
  while (i > 0)
  {
    ans[p[i][j][k]].push_back(a[i - 1]);
    if (p[i][j][k] == 1)
      j -= a[i - 1];
    else if (p[i][j][k] == 2)
      k -= a[i - 1];
    i--;
  }
  for (int ii = 0; ii < 3; ii++)
  {
    printf("%d", ans[ii].size());
    for (int jj = 0; jj < ans[ii].size(); jj++)
      printf(" %d", ans[ii][jj]);
    printf("\n");
  }
  return 0;
}
