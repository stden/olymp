#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>

using namespace std;

#define TASKNAME "dynarray"

int main() {
  freopen(TASKNAME ".in", "r", stdin);
  freopen(TASKNAME ".out", "w", stdout);
  
  int n, m;
  while (scanf("%d", &n) != EOF) {
    scanf("%d", &m);
    vector<int> arr(n);
    for (int i = 0; i < n; i++) {
      int tmp; scanf("%d", &tmp);
      arr[i] = tmp;
    }
    for (int x = 0; x < m; x++) {
      int ty, u, v, p;
      scanf("%d", &ty);
      switch (ty) {
	case 1:scanf("%d %d", &u, &p); u--;
	  arr[u] = p;
	  break;
	case 2:scanf("%d %d", &u, &p); u--;
	  arr.push_back(arr[n - 1]);
	  for (int i = u + 1; i < n; i++) arr[i + 1] = i;
	  arr[u + 1] = p; n++;
	  break;
	case 3:scanf("%d %d %d", &u, &v, &p); u--, v--;
	  int ans = 0;
	  for (int i = u; i <= v; i++)
	    ans += !!(arr[i] <= p);
	  printf("%d\n", ans);
	  break;
      }
    }
  }
  return 0;
}