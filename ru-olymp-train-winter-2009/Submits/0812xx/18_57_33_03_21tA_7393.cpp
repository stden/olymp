#include <cstdio>
#include <iostream>
#include <cstring>
#include <cmath>

using namespace std;

int n, m, k, v;
int best[100][500];
int all[100][500];
int g[100][100];
int a[100][100], d[100][100];

int calc (int i, int mask, int dis, int sum) {
  if (all[i][mask] == -1 || all[i][mask] > sum)
    all[i][mask] = sum;
  for (int j = 0; j < k; j++)
    if (a[i][j] != 0 && ((mask >> j) & 1) == 0)
      calc (i, mask + (1 << j), dis + d[i][j], sum + a[i][j] / 100 * (100 - dis));
  return 0;
}

int main () {
  freopen ("armor.in", "rt", stdin);
  freopen ("armor.out", "wt", stdout);
  scanf ("%d%d%d%d", &n, &m, &k, &v); v--;
  int km = 1 << k;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < k; j++)
      scanf ("%d%d", &a[i][j], &d[i][j]);
    for (int j = 0; j < km; j++)
      all[i][j] = -1;
    calc (i, 0, 0, 0);
//    for (int j = 0; j < km; j++)
//      printf ("%d %d %d\n", i, j, all[i][j]);    
  }
  for (int i = 0; i < n; i++)
    for (int j = 0; j < km; j++)
      best[i][j] = -1;
  best[v][0] = 0;
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
      g[i][j] = -1;
  for (int i = 0; i < m; i++) {
    int x, y, z;
    scanf ("%d%d%d", &x, &y, &z); x--; y--;
    if (g[x][y] == -1) g[x][y] = z;
    if (g[x][y] > z) g[x][y] = z;
    g[y][x] = g[x][y];
  }
  for (int k = 0; k < n; k++)
    for (int i = 0; i < n; i++)
      for (int j = 0; j < n; j++)
	if (g[i][k] != -1 && g[k][j] != -1)
	  if (g[i][j] == -1 || g[i][j] > g[i][k] + g[k][j])
	    g[i][j] = g[i][k] + g[k][j];
  for (int j = 0; j < km; j++)
    for (int i = 0; i < n; i++)
      if (best[i][j] != -1) {
	for (int kk = j; kk < km; kk++) 
	  if ((kk | j) == kk){
	  int k = kk - j;
	  for (int l = 0; l < n; l++)
	    if (g[i][l] != -1 && all[l][k] != -1 && (best[l][kk] == -1 || best[l][kk] > best[i][j] + all[l][k] + g[i][l])) {
	      best[l][kk] = best[i][j] + all[l][k] + g[i][l];
	    }
	}
      }
  int ans = best[v][km - 1];
  for (int i = 0; i < n; i++)
    if (g[i][v] != -1 && best[i][km - 1] != -1)
      if (ans == -1 || ans > best[i][km - 1] + g[i][v])
	ans = best[i][km - 1] + g[i][v];
  printf ("%d\n", ans);
}