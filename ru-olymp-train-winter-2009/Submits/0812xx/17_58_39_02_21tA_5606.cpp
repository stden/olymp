#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>

using namespace std;

#define TASKNAME "armor"
#define MAXN 50
#define MAXK 7
#define INF 2000000000

inline void relax(int& a, int b) {
  if (a > b) a = b;
}

struct state {
  int v, mask;
};

int n, k;
vector< pair<int, state> > gr[MAXN][1 << MAXK];
bool red[MAXN][1 << MAXK];
int d[MAXN][1 << MAXK];

void dijkstra(int stv, int stmask) {
  for (int i = 0; i < n; i++)
    for (int mask = 0; mask < (1 << k); mask++)
      d[i][mask] = INF;
  d[stv][stmask] = 0;
  while (1) {
    int min = INF, minv, minm;
    minv = -1; minm = 0;
    for (int v = 0; v < n; v++)
      for (int mask = 0; mask < (1 << k); mask++)
	if (!red[v][mask] && (d[v][mask] < min)) {
	  min = d[v][mask];
	  minv = v; minm = mask;
	}
    if (minv < 0) break;
    //printf("%d, %d: %d\n", minv, minm, min);
    red[minv][minm] = true;
    for (int i = 0; i < gr[minv][minm].size(); i++) {
      pair<int, state> x = gr[minv][minm][i];
      if (red[x.second.v][x.second.mask]) continue;
      //printf("  -%d-> %d, %d\n", x.first, x.second.v, x.second.mask);
      relax(d[x.second.v][x.second.mask], min + x.first);
    }
  }
}

int main() {
  freopen(TASKNAME ".in", "r", stdin);
  freopen(TASKNAME ".out", "w", stdout);

  int m, st;
  int ed[MAXN][MAXN];
  int pr[MAXN][MAXK], dis[MAXN][MAXK];
  scanf("%d %d %d %d", &n, &m, &k, &st); st--;
  for (int a = 0; a < n; a++) for (int b = 0; b < n; b++) ed[a][b] = INF;
  for (int a = 0; a < n; a++) ed[a][a] = 0;
  
  for (int i = 0; i < n; i++)
     for (int i2 = 0; i2 < k; i2++)
       scanf("%d %d", &pr[i][i2], &dis[i][i2]);
  for (int i = 0; i < m; i++) {
    int a, b, c; scanf("%d %d %d", &a, &b, &c), a--, b--;    
    if (c < ed[a][b]) ed[a][b] = ed[b][a] = c;
  }
      
  int count[1 << MAXK]; count[0] = 0;
  int pow[1 << MAXK]; memset(pow, 0, sizeof pow);
  for (int i = 1; i < (1 << k); i++) count[i] = count[i & (i - 1)] + 1;
  for (int i = 0; i < MAXK; i++) pow[1 << i] = i;
  
  int minprice[MAXN][1 << MAXK];
  for (int i = 0; i < n; i++)
    for (int buy = 0; buy < (1 << k); buy++) {
      int wb = count[buy]; bool allcbuy = true;
      vector<int> per(wb);      
      int tmp = buy;
      for (int i2 = 0; i2 < wb; i2++) {
	per[i2] = pow[ tmp ^ (tmp & (tmp - 1)) ];
	if (!pr[i][per[i2]]) {allcbuy = false; break;}
	tmp &= tmp - 1;
      }       
      
      minprice[i][buy] = INF;
      if (!allcbuy) continue;
      do {
	int price = 0;
	int disc = 100;
	for (int i2 = 0; i2 < wb; i2++) {
	  price += disc * pr[i][per[i2]] / 100;
	  disc -= dis[i][per[i2]];
	}
	minprice[i][buy] = min(minprice[i][buy], price);
      } while (next_permutation(per.begin(), per.end()));
    }

  for (int v = 0; v < n; v++)
    for (int mask = 0; mask < (1 << k); mask++) {
      for (int buy = (mask + 1) | mask;
	    buy < (1 << k); buy = (buy + 1) | mask)
	if (minprice[v][mask ^ buy] < INF) {
	  state stat; stat.v = v; stat.mask = buy;
	  gr[v][mask].push_back(make_pair(minprice[v][mask ^ buy], stat));
	}
      for (int u = 0; u < n; u++)
	if (ed[v][u] < INF) {
	  state stat; stat.v = u; stat.mask = mask;
	  gr[v][mask].push_back(make_pair(ed[v][u], stat));
	}      
    }
  dijkstra(st, 0);
  if (d[st][(1 << k) - 1] < INF) printf("%d\n", d[st][(1 << k) - 1]);
  else printf("-1\n");
  return 0;
}
