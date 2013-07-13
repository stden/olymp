#include <cstdio>
#include <algorithm>
#include <vector>

using namespace std;

typedef vector <int> VI;
typedef pair <int, int> PII;

#define PB push_back
#define MP make_pair
#define F first
#define S second

#define m 50050

int n;
VI to[m];
vector <PII> ans;
int _stklen = 10 << 20;

bool mless( PII a, PII b )
{
  return a.S == -1 && b.S != -1;
}

PII dfs( int v, int p )
{
  if (to[v].size() == 2 && p != -1)
    return dfs(to[v][0] + to[v][1] - p, v);
  vector <PII> t;
  int nu = 0;
  if (to[v].size() == 1)
    return MP(v, -1);
  for (int i = 0; i < to[v].size(); i++)
    if (to[v][i] != p)
      t.PB(dfs(to[v][i], v)), nu += 2 - (t[t.size() - 1].S == -1);
  sort(t.begin(), t.end(), mless);
  PII res;
  if (p != -1)
    if (nu & 1)
      if (t[t.size() - 1].S == -1)
        res = MP(t[t.size() - 1].F, -1), t[t.size() - 1].F = -1;
      else
        res = MP(t[t.size() - 1].S, -1), t[t.size() - 1].S = -1;
    else
      if (t[t.size() - 1].S == -1)
        res = MP(t[t.size() - 1].F, t[t.size() - 2].F), t[t.size() - 1].F = t[t.size() - 2].F = -1;
      else
        if (t[t.size() - 2].S == -1)
          res = MP(t[t.size() - 1].S, t[t.size() - 2].F), t[t.size() - 1].S = t[t.size() - 2].F = -1, t[t.size() - 2] = t[t.size() - 1];
        else
          res = MP(t[t.size() - 1].S, t[t.size() - 2].S), t[t.size() - 1].S = t[t.size() - 2].S = -1;
  else
    res = MP(-1, -1);
  int n = t.size();
  while (n > 0 && t[n - 1].F == -1)
    n--;
//  printf("n=%d\n", n);
  sort(t.begin(), t.begin() + n, mless);
//  for (int i = 0; i < n; i++)
//    printf("t[%d]=%d %d\n", i, t[i].F, t[i].S);
  int k;
  for (k = n - 1; k >= 0 && t[k].S != -1; k--)
    ;
  k++;
//  printf("k=%d\n", k);
  if (k != n - 1)
  {
    for (int i = k; i + 1 < n; i++)
      ans.PB(MP(t[i].S, t[i + 1].F));//, printf("->>%d %d\n", t[i].S, t[i + 1].F);
    if (k != n)
      ans.PB(MP(t[n - 1].S, t[k].F));//, printf("->>%d %d\n", t[n - 1].S, t[k].F);
  }
  else
    ans.PB(MP(t[n - 1].F, t[n - 2].F)), ans.PB(MP(t[n - 1].S, t[n - 3].F)), k = n - 3;
//  printf("k=%d\n", k);
  while (k > 1)
    ans.PB(MP(t[k - 1].F, t[k - 2].F)), k -= 2;
  if (k == 1)
    ans.PB(MP(t[0].F, t[n - 1].F));
//  printf("dfs(%d %d)\n", v, p);
//  printf("res=%d %d\n", res.F, res.S);
  return res;
}

int main( void )
{
  freopen("biconn.in", "rt", stdin);
  freopen("biconn.out", "wt", stdout);
  scanf("%d", &n);
  for (int i = 1; i < n; i++)
  {
    int a, b;
    scanf("%d%d", &a, &b), a--, b--;
    to[a].PB(b), to[b].PB(a);
  }
  if (n == 1)
  {
    printf("0");
    return 0;
  }
  if (n == 2)
  {
    printf("1\n1 2");
    return 0;
  }
  for (int i = 0; i < n; i++)
    if (to[i].size() > 1)
    {
      dfs(i, -1);
      break;
    }
  printf("%d\n", ans.size());
  for (int i = 0; i < ans.size(); i++)
    printf("%d %d\n", ans[i].F + 1, ans[i].S + 1);
  return 0;
}
