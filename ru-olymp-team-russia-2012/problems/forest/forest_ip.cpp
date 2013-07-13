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
#include <set>

using namespace std;

typedef pair<int, int> pii;
typedef long long ll;
typedef vector<int> vi;
typedef vector<vi> vvi;
typedef vector<ll> vll;
typedef vector<vll> vvll;

#define sz(x) ((int)(x).size())
#define eprintf(...) fprintf(stderr, __VA_ARGS__)
#define EPS (1e-9)
#define INF ((int)1e9)
#define mp make_pair
#define pb push_back
#define TASKNAME "forest"

const int maxn = 100;
int a[maxn][maxn];
int b[maxn][maxn];
int dist[maxn][maxn];
multiset<pair<pii, pii> > S;

const int go[4][2] = {{1, 0}, {0, 1}, {-1, 0}, {0, -1}};
int main() {          
  freopen(TASKNAME".in", "r", stdin);
  freopen(TASKNAME".out", "w", stdout);

  int h, w;
  while (scanf("%d%d", &h, &w) >= 1) {
    for (int i = 0; i < h; i++)
      for (int j = 0; j < w; j++)
        scanf("%d", &a[i][j]);
    memset(dist, 0, sizeof(dist));

    S.clear();
    for (int i = 0; i < h; i++)
      for (int j = 0; j < w; j++) {
        for (int g = 0; g < 4; g++) {
          int y = i + go[g][0], x = j + go[g][1];
          if (y < 0 || x < 0 || y >= h || x >= w)
            continue;
          if (a[y][x] == a[i][j] + 1) {
            //eprintf("adding (0 %d   %d %d)\n", a[i][j], i, j);
            S.insert(mp(mp(0, a[i][j]), mp(i, j)));
          }
        }
      }
    
    int ans = 0;
    while (sz(S)) {
      pair<pii, pii> cur = *S.begin();
      int i = cur.second.first, j = cur.second.second;
      
      //eprintf("sz(S) = %d\n", sz(S));
      for (int iter = 0; iter < 2; iter++) {
        for (int g = 0; g < 4; g++) {
          int y = i + go[g][0], x = j + go[g][1];
          if (y < 0 || x < 0 || y >= h || x >= w)
            continue;
          if (abs(a[y][x] - a[i][j]) == 1) {
            pair<pii, pii> with(mp(max(dist[i][j], dist[y][x]), min(a[i][j], a[y][x])), a[y][x] > a[i][j] ? mp(i, j) : mp(y, x));
            //eprintf("with: (%d %d   %d %d)\n", with.first.first, with.first.second, with.second.first, with.second.second);
            if (!iter) {
              multiset<pair<pii, pii> >::iterator itr = S.find(with);
              assert(itr != S.end());
              S.erase(itr);
            } else
              S.insert(with);
          }
        }

        if (!iter) {
          a[i][j]++;
          dist[i][j] = cur.first.first + 1;
          ans = max(ans, dist[i][j]);
        }
      }
    }
    /*for (int i = 0; i < h; i++)
      for (int j = 0; j < w; j++)
        eprintf("%d%c", a[i][j], " \n"[j == w - 1]);
    eprintf("\n");
    for (int i = 0; i < h; i++)
      for (int j = 0; j < w; j++)
        eprintf("%I64d%c", dist[i][j], " \n"[j == w - 1]);
    eprintf("\n\n");*/
    
    printf("%d\n", ans);
    for (int i = 0; i < h; i++)
      for (int j = 0; j < w; j++)
        printf("%d%c", a[i][j], " \n"[j == w - 1]);
    //break;
  }

  return 0;
}
