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

bool nextsequence(vector<int> &seq, int n) {
  int sl = seq.size();
  int bfr = sl - 1;
  for (; bfr >= 0; bfr--) if (seq[bfr] != n - sl + bfr) {bfr++; break;}
  if (bfr < 0) return false;
  seq[bfr - 1]++; for (int i = bfr; i < sl; i++) seq[i] = seq[i - 1] + 1;
  return true;
}

// #define precalc
int main() {
  freopen(TASKNAME ".in", "r", stdin);
  freopen(TASKNAME ".out", "w", stdout);

#ifdef precalc
  int c[100][100];
  c[0][0] = 1;
  for (int n = 1; n < 100; n++) {
    c[n][0] = c[n][n] = 1;
    for (int k = 1; k < n; k++)
      c[n][k] = c[n - 1][k - 1] + c[n - 1][k];
  }
  long long ans = 32381000;
  for (int i = 1; i <= MAXK; i++)
    ans += (long long)c[MAXN][i];
  printf("%lld\n", ans);
#else
  int n, m, k, st;
  int d[MAXN][MAXN];
  int pr[MAXN][MAXK], dis[MAXN][MAXK];
  scanf("%d %d %d %d", &n, &m, &k, &st); st--;
  for (int a = 0; a < n; a++) for (int b = 0; b < n; b++) d[a][b] = INF;
  for (int a = 0; a < n; a++) d[a][a] = 0;
  
  for (int i = 0; i < n; i++)
     for (int i2 = 0; i2 < k; i2++)
       scanf("%d %d", &pr[i][i2], &dis[i][i2]);
  for (int i = 0; i < m; i++) {
    int a, b, c; scanf("%d %d %d", &a, &b, &c), a--, b--;    
    if (c < d[a][b]) d[a][b] = d[b][a] = c;
  }
  for (int i = 0; i < n; i++) //Флоид
    for (int j = 0; j < n; j++)
      for (int k = 0; k < n; k++)
	d[j][k] = min(d[j][k], d[j][i] + d[i][k]);
      
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
	if (!pr[i][i2]) {allcbuy = false; break;}
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
   
  int ans = INF;
  for (int i = 0; i < n; i++)
    ans = min(ans, (d[st][i] << 1) + minprice[i][(1 << k) - 1]);
  /*for (int seqlen = 2; seqlen <= k; seqlen++) {
    if (seqlen > n) break;
    vector<int> seq(seqlen);
    for (int i = 0; i < seqlen; i++) seq[i] = i;
    
    do {      
      //int curans = d[st][seq[0]] + d[seq[seqlen - ]][st];
      
            
      //ans = min(ans, curans);
    } while(nextsequence(seq, n));
  }*/
  printf("%d\n", ans);
#endif
  return 0;
}
