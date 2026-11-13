#include <cstdio>
#include <ctime>
#include <vector>
#include <cstdlib>

using namespace std;

vector < vector <int> > e;


vector <int> lists;
int was[60000];

void dfs( int v )
{
  was[v] = 1;
  int f = 1;
  for (int i = 0; i < e[v].size(); i++)
    if (!was[e[v][i]])
      dfs(e[v][i]), f = 0;
  if (f)
    lists.push_back(v);
}

int main( void )
{
  freopen("biconn.in", "rt", stdin);
  freopen("biconn.out", "wt", stdout);

  int n;
  srand(time(NULL));
  scanf("%d", &n);
  e.resize(n + 1);
  for (int a, b, i = 0; i < n - 1; i++)
  {
    scanf("%d%d", &a, &b);
    e[a].push_back(b);
    e[b].push_back(a);
  }
  if (n == 1)
  {
    printf("0");
    return 0;
  }
  if (n == 2)
  {
    printf("1\n1 2\n");
    return 0;
  }
  int st;
  for (int i = 1; i <= n; i++)
    if (e[i].size() >= 2 && (rand() % 3 == 0))
    {
      st = i;
      break;
    }
  dfs(st);
  int l = 0, r = lists.size() - 1;
  printf("%d\n", (l + r + 2) / 2);
  while (l < r)
  {
    printf("%d %d\n", lists[l], lists[r]); 
    l++, r--;
  }
  if (l == r)
    printf("%d %d", lists[l], st);
  return 0;
}