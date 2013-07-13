#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <algorithm>
#include <cassert>
#include <cstring>
#include <string>
#include <vector>
#include <ctime>
#include <iostream>

using namespace std;

typedef long long ll;
typedef vector<int> vi;
typedef vector<vi> vvi;
typedef vector<ll> vll;
typedef vector<vll> vvll;

#define sz(x) ((int)(x).size())
#define eprintf(...) fprintf(stderr, __VA_ARGS__)
#define EPS (1e-9)
#define INF ((int)2e9 + 1)
#define mp make_pair
#define pb push_back
#define TASKNAME "jediacademy"

const int maxn = (int)1e5 + 1;
vvi es;
int deg[maxn];

int st[2][maxn];
int type[maxn];

int main() {
  freopen(TASKNAME".in", "r", stdin);
  freopen(TASKNAME".out", "w", stdout);

  int n;
  while (scanf("%d", &n) >= 1) {
    es = vvi(n + 1);
    for (int i = 0; i < n; i++) {
      scanf("%d", &type[i + 1]);
      type[i + 1]--;
      int k;
      scanf("%d", &k);
      for (int j = 0; j < k; j++) {
        int x;
        scanf("%d", &x);
        es[x].pb(i + 1);
      }
    }
    for (int i = 0; i < n; i++)
      es[0].pb(i + 1);
    ++n;

    int a, b;
    scanf("%d%d", &a, &b);
    
    int ans = INF;
    for (type[0] = 0; type[0] < 2; type[0]++) {
      memset(deg, 0, sizeof(deg));
      for (int i = 0; i < n; i++)
        for (int it = 0; it < sz(es[i]); it++) {
          int u = es[i][it];
          deg[u]++;
        }

      int l[2] = {0, 0};
      int r[2] = {0, 0};
      st[type[0]][r[type[0]]++] = 0;

      int cur = 0;
      for (int col = type[0]; l[0] + l[1] < r[0] + r[1]; col ^= 1, cur++) {
        while (l[col] < r[col]) {
          int v = st[col][l[col]];
          assert(!deg[v]);
          for (int it = 0; it < sz(es[v]); it++) {
            int u = es[v][it];
            if (!--deg[u]) {
              st[type[u]][r[type[u]]++] = u;
              //eprintf("killed %d at %d\n", u, cur);
            }
          }
          l[col]++;
        }
      }
      assert(r[0] + r[1] == n);

      //eprintf("cur = %d\n", cur);
      ans = min(ans, cur * a + b * (n - 1));
    }

    printf("%d\n", ans);

    //break;
  }

  return 0;
}
