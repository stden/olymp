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
#define INF ((int)1e9)
#define mp make_pair
#define pb push_back
#define TASKNAME "loudcats"

const int maxn = 200;
int a[maxn];

int main() {
  freopen(TASKNAME".in", "r", stdin);
  freopen(TASKNAME".out", "w", stdout);

  int n, m, d;
  while (scanf("%d%d%d", &n, &m, &d) >= 1) {
    int ans = 0;
    for (int i = 0; i < n * m; i++) {
      scanf("%d", &a[i]);
      if (i >= m && a[i] > 2 * a[i - m])
        ans++;
    }
    printf("%d\n", ans * d);
    //break;
  }

  return 0;
}
