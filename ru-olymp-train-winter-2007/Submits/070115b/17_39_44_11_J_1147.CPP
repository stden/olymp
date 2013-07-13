#include <cstdio>
#include <set>
#include <algorithm>
#include <vector>

using namespace std;

#define m 30300

vector <int> to[m], we[m];
int d[m], n, e;

class hless
{
public:
  bool operator()( int a, int b )
  {
    if (d[a] != d[b])
      return d[a] < d[b];
    return a < b;
  }
};

int main( void )
{
  freopen("path.in", "rt", stdin);
  freopen("path.out", "wt", stdout);
  scanf("%d%d", &n, &e);
  for (int i = 0; i < e; i++)
  {
    int a, b, c;
    scanf("%d%d%d", &a, &b, &c), a--, b--;
//    if (a == b)
//      continue;
    to[a].push_back(b);
    we[a].push_back(c);
    to[b].push_back(a);
    we[b].push_back(c);
  }
  set <int, hless> q;
  for (int i = 1; i < n; i++)
    d[i] = (int)1e9;
  d[0] = 0;
  for (int i = 0; i < n; i++)
    q.insert(i);
  while (!q.empty())
  {
    int v = *q.begin();
    q.erase(v);
    for (int i = 0; i < to[v].size(); i++)
      if (d[to[v][i]] > d[v] + we[v][i])
      {
        q.erase(to[v][i]);
        d[to[v][i]] = d[v] + we[v][i];
        q.insert(to[v][i]);
      }
  }
  for (int i = 0; i < n; i++)
    printf("%d ", d[i]);
  return 0;
}
