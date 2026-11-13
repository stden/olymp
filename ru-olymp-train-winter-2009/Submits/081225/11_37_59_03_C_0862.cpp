#include <cstdio>
#include <vector>
#include <algorithm>
#include <cmath>
#include <cstring>

using namespace std;

#define taskname "dynarray"

int a[1000000];

int main () {
  freopen (taskname".in", "rt", stdin);
  freopen (taskname".out", "wt", stdout);
  int n, m;
  scanf ("%d%d", &n, &m);
  for (int i = 0; i < n; i++)
    scanf ("%d", &a[i]);
  for (int i = 0; i < m; i++) {
    int t, x, y, z;
    scanf ("%d", &t);
    if (t == 1) {
      scanf ("%d%d", &x, &y);
      a[x - 1] = y;
    }
    if (t == 2) {
      scanf ("%d%d", &x, &y);
      for (int j = n; j > x; j--)
	a[j] = a[j - 1];
      a[x] = y;
      n++;
    }
    if (t == 3) {
      scanf ("%d%d%d", &x, &y, &z);
      int ans = 0;
      for (int j = x - 1; j < y; j++)
	if (a[j] <= z) ans++;
      printf ("%d\n", ans);    
    }
  }
}