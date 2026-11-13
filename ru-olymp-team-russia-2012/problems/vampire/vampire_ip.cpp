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
#define TASKNAME "vampire"

const int maxn = (int)1e6;
int ans[maxn][2];

int cnt[10];
int sumcnt;

void addcnt(int x, int coef) {
  while (x) {
    int k = x % 10;
    sumcnt += ((coef == 1 && cnt[k] >= 0) || (coef == -1 && cnt[k] <= 0)) ? 1 : -1;
    cnt[k] += coef;
    x /= 10;
  }

  int sum = 0;
  for (int i = 0; i < 10; i++)
    sum += abs(cnt[i]);
  assert(sum == sumcnt);
}

int res[maxn];
void solve(int k, int n) {
  //eprintf("solve(%d, %d)\n", k, n);
  int start = 1;
  for (int i = 0; i < n / 2 - 1; i++, start *= 10) ;
  
  memset(cnt, 0, sizeof(cnt));
  sumcnt = 0;

  memset(ans, -1, sizeof(ans));

  for (int i = start; i < start * 10; i++) {
    addcnt(i, 1);
    for (int j = start; j < start * 10; j++) {
      int cur = i * j;
      if (cur < start * start * 10)
        continue;
      //eprintf("cur = %d\n", cur);
      addcnt(j, 1);
      addcnt(cur, -1);
      if (!sumcnt) {
        ans[cur][0] = i, ans[cur][1] = j;
        //eprintf("%d\n", cur);
      }
      addcnt(cur, 1);
      addcnt(j, -1);
    }    
    addcnt(i, -1);
    assert(!sumcnt);
  }

  start = start * start * 10;
  for (int i = start; i < start * 10 && k; i++) {
    if (ans[i][0] == -1)
      continue;
    res[--k] = i;
  }
  assert(!k);
}


inline void myprint(int x, int more) {
  printf("%d", x);
  for (int i = 0; i < more; i++)
    printf("0");
}

int main() {
  freopen(TASKNAME".in", "r", stdin);
  freopen(TASKNAME".out", "w", stdout);

  int k, n;
  while (scanf("%d%d", &k, &n) >= 1) {
    solve(k, min(n, 6));
    
    for (int i = 0; i < k; i++) {
      myprint(res[i], n - min(n, 6));
      printf("=");
      myprint(ans[res[i]][0], n / 2 - min(n, 6) / 2);
      printf("x");
      myprint(ans[res[i]][1], n / 2 - min(n, 6) / 2);
      printf("\n");
    }
    //break;
  }

  return 0;
}
