#include <algorithm>
#include <cstdio>
#include <cstring>

using namespace std;

#define m 210
#define mp 1010

int n, k, p, di[mp], c[m][m];

int main( void )
{
  freopen("optimum.in", "rt", stdin);
  freopen("optimum.out", "wt", stdout);
  memset(c, 0, sizeof(c));
  scanf("%d%d%d", &n, &k, &p);
  for (int i = 1; i < p; i++)
    for (int j = 1; j < p; j++)
      if ((i * j) % p == 1)
      {
        di[i] = j;
        break;
      }
  for (int i = 0; i < k; i++)
  {
    int a, b;
    scanf("%d%d", &a, &b), a--, b--;
    c[a][b]++, c[b][a]++, c[a][a]++, c[b][b]++;
  }
  n--;
  int s = 1;
  for (int i = 0; i < n; i++)
  {
    int jj = -1;
    for (int j = i; jj == -1 && j < n; j++)
      if (c[j][i] != 0)
        jj = j;
    if (jj == -1)
    {
      printf("0");
      return 0;
    }
    if ((jj - i + 1) & 1)
      s *= -1;
    for (int j = i; j < n; j++)
      swap(c[i][j], c[jj][j]);
    for (int j = i + 1; j < n; j++)
    {
      int t = (c[j][i] * di[c[i][i]]) % p;
      for (int k = i; k < n; k++)
        c[j][k] -= (t * c[i][k]) % p;
    }
  }
  int ans = 1;
  for (int i = 0; i < n; i++)
    ans = (ans * c[i][i]) % p;
  ans *= s;
  while (ans < 0)
    ans += p;
  ans %= p;
  printf("%d", ans);
  return 0;
}
