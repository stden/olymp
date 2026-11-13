#include <cstdio>
#include <set>
#include <vector>

using namespace std;

#define PB push_back
#define MP make_pair
#define FI first
#define SE second

vector <pair<int, int> > V[30010];

int D[30010];

int main( void )
{
  freopen("path.in", "rt", stdin);
  freopen("path.out", "wt", stdout);

  int N, M;
  scanf("%d%d", &N, &M);
  for (int i = 0; i < M; i++)
  {
    int a, b, c;
    scanf("%d%d%d", &a, &b, &c);
    V[a - 1].PB(MP(b - 1, c));
    V[b - 1].PB(MP(a - 1, c));
  }
  set<pair<int, int> > A;
  memset(D, 127, sizeof(D));
  D[0] = 0;
  A.insert(MP(0, 0));
  while (A.size())
  {
    int t = A.begin()->SE;
    A.erase(MP(D[t], t));
    for (int i = 0; i < V[t].size(); i++)
      if (D[V[t][i].FI] > D[t] + V[t][i].SE)
      {
        A.erase(MP(D[V[t][i].FI], V[t][i].FI));
        D[V[t][i].FI] = D[t] + V[t][i].SE;
        A.insert(MP(D[V[t][i].FI], V[t][i].FI));
      }
  }
  for (int i = 0; i < N; i++)
    printf("%d%c", D[i], i < N - 1 ? ' ' : '\n');

  return 0;
}
