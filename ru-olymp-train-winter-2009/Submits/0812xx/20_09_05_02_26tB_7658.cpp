#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>

using namespace std;

#define TASKNAME "half"

bool g[30][30];
int cnk[31][31];
int order[80000000]; int ol = 0;

void calc_cnk() {
  for (int n = 0; n <= 30; n++) {
    cnk[n][0] = cnk[n][n] = 1;
    for (int k = 1; k < n; k++)
      cnk[n][k] = cnk[n - 1][k - 1] + cnk[n - 1][k];
  }
}

void gen(int from, bool ortrue, char n, char k, int mask, char curel) {
  if (k == 0) {order[from] = 0 | mask; return;}
  if (k == n) {order[from] = (((1 << n) - 1) << curel) | mask; return;}
  if (ortrue) {
    gen(from, true, n - 1, k, mask, curel + 1);
    gen(from + cnk[n - 1][k], false, n - 1, k - 1, mask | (1 << curel), curel + 1);
  } else {
    gen(from, true, n - 1, k - 1, mask | (1 << curel), curel + 1);
    gen(from + cnk[n - 1][k - 1], false, n - 1, k, mask, curel + 1);
  }
}

char ecount[30][3][1024];

int main() {
  freopen(TASKNAME ".in", "r", stdin);
  freopen(TASKNAME ".out", "w", stdout);
  
  calc_cnk();
  
  int n;
  while (scanf("%d", &n) != EOF) {
    memset(g, 0, sizeof g);
    
    int m; scanf("%d", &m);
    for (int i = 0; i < m; i++) {
      int a, b; scanf("%d %d", &a, &b);
      a--, b--;
      g[a][b] = g[b][a] = 1;
    }
    
    memset(ecount, 0, sizeof ecount);
    for (int i = 0; i < n; i++)
      for (int off = 0; off < n; off += 10) {
	int step = 1 << off;
	for (int st = step; st < (1 << (off + 10)); st += step) {
	  ecount[i][off / 10][st >> off] = 0;
	  for (int ver = 1; ver <= st; ver <<= 1)
	    if ((st & ver) && g[i][__builtin_ctz(ver)])
	      ecount[i][off / 10][st >> off]++;
	}
      }
    
    int ans, best;
        
    gen(0, true, n - 1, (n >> 1) - 1, 1, 1); ol = cnk[n - 1][(n >> 1) - 1];
    best = order[0]; ans = 0;
    for (int ver = 1; ver <= best; ver <<= 1)
      if (best & ver) {
        ans += ecount[__builtin_ctz(ver)][0][~best & 1023];
        ans += ecount[__builtin_ctz(ver)][1][(~best >> 10) & 1023];
        ans += ecount[__builtin_ctz(ver)][2][(~best >> 20) & 1023];
      }
    int curans = ans;
    for (int i = 1; i < ol; i++) {
      int pr = order[i - 1], now = order[i]; 
      int diff, del, add;
      diff = pr ^ now;
      del = pr & diff;
      add = now & diff;
      
      curans -= ecount[__builtin_ctz(del)][0][~pr & 1023];
      curans -= ecount[__builtin_ctz(del)][1][(~pr >> 10) & 1023];
      curans -= ecount[__builtin_ctz(del)][2][(~pr >> 20) & 1023];
      curans += ecount[__builtin_ctz(del)][0][now & 1023];
      curans += ecount[__builtin_ctz(del)][1][(now >> 10) & 1023];
      curans += ecount[__builtin_ctz(del)][2][(now >> 20) & 1023];

      curans += ecount[__builtin_ctz(add)][0][~now & 1023];
      curans += ecount[__builtin_ctz(add)][1][(~now >> 10) & 1023];
      curans += ecount[__builtin_ctz(add)][2][(~now >> 20) & 1023];
      curans -= ecount[__builtin_ctz(add)][0][pr & 1023];
      curans -= ecount[__builtin_ctz(add)][1][(pr >> 10) & 1023];
      curans -= ecount[__builtin_ctz(add)][2][(pr >> 20) & 1023];
      
      if (curans < ans) {
	ans = curans;
	best = order[i];
      }
    }
    
    printf("1");
    for (int off = 2; off <= best; off <<= 1)
      if (best & off) printf(" %d", __builtin_ctz(off) + 1);
    printf("\n");
  }
  
  return 0;
}