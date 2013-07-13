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
#define TASKNAME "chaotic"

const int maxn = 1000;
int a[maxn];
int ans[maxn];

int main() {
  freopen(TASKNAME".in", "r", stdin);
  freopen(TASKNAME".out", "w", stdout);

  int n;

  while (scanf("%d", &n) >= 1) {
    for (int i = 0; i < n; i++)
      scanf("%d", &a[i]);
    
    int res = 0;
    for (int i = 2; i < n; i++) {
      if ((a[i] - a[i - 1]) * (a[i - 1] - a[i - 2]) > 0)
        ans[res++] = i, swap(a[i], a[i - 1]);  
    }

    printf("%d\n", res);
    for (int i = 0; i < res; i++)
      printf("%d%c", ans[i], " \n"[i == res - 1]);
    //break;                   
  }

  return 0;
}
