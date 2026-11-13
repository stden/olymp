#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>

using namespace std;

#define TASKNAME "half"

bool g[30][30];

int main() {
  freopen(TASKNAME ".in", "r", stdin);
  freopen(TASKNAME ".out", "w", stdout);
  
  int n;
  while (scanf("%d", &n) != EOF) {
    memset(g, 0, sizeof g);
    
    int m; scanf("%d", &m);
    for (int i = 0; i < m; i++) {
      int a, b; scanf("%d %d", &a, &b);
      a--, b--;
      g[a][b] = g[b][a] = 1;
    }
    
    int hn = n >> 1;
    
    vector<int> mask(n);
    for (int i = 0; i < hn; i++) mask[i] = 0;
    for (int i = hn; i < n; i++) mask[i] = 1;

    int ans = 1000000;
    vector<int> best = mask;
    do {
      if (mask[0]) break;
      
      int curans = 0;
      for (int i = 0; i < n; i++) {
	if (mask[i]) continue;
	for (int i2 = 0; i2 < n; i2++) {
	  if (!mask[i2]) continue;
	  if (g[i][i2]) curans++;
	}	
      }
      if (curans < ans) {
	ans = curans;
        best = mask;
      }
    } while (next_permutation(mask.begin(), mask.end()));
    
    bool need = best[0];
    printf("1");
    for (int i = 1; i < n; i++)
      if (best[i] == need) printf(" %d", i + 1);
    printf("\n");
  }
  
  return 0;
}