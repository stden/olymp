#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <map>
#include <set>
#include <string>
#include <utility>
#include <vector>

using namespace std;

#define PB push_back
#define MP make_pair
#define FI first
#define SE second

typedef vector <int> VI;
typedef pair <int, int> PII;
typedef long long Long;


#define maxl 10010
#define maxk 10010
#define maxc 26
#define maxn 110

char Temp[maxl];
string Str[maxk], Ret[maxn][maxk];
int Jump[maxk][maxc], Pref[maxk], End[maxk][maxc], Parent[maxk];
Long Cost[maxk], Add[maxk][maxc], D[maxn][maxk];

int CP( int i )
{
  if (Pref[i] != -1)
    return Pref[i];
  int V = Parent[i];
  char c;
  for (c = 0; c < 26 && Jump[V][c] != i; c++)
    ;
  int Temp = CP(V);
  if (V == 0)
    return Pref[i] = 0;
  while (Temp != 0 && Jump[Temp][c] == -1)
    Temp = CP(Temp);
  if (Jump[Temp][c] != -1)
    Temp = Jump[Temp][c];
  return Pref[i] = Temp;
}

int main( void )
{
  freopen("beauty.in", "rt", stdin);
  freopen("beauty.out", "wt", stdout);

  int K, N;
  scanf("%d", &K);
  for (int i = 0; i < K; i++)
  {
    scanf("%s%d", Temp, &Cost[i]);
    Str[i] = Temp;
  }
  scanf("%d", &N);

  memset(Jump, -1, sizeof(Jump));
  memset(Pref, -1, sizeof(Pref));
  memset(Add, 0, sizeof(Add));
  memset(End, -1, sizeof(End));
  memset(Parent, -1, sizeof(Parent));
  int Root = 0, Vertex = 1;
  for (int i = 0; i < K; i++)
    if ((int)Str[i].length() <= N)
    {
      int V = Root;
      for (int j = 0; j < (int)Str[i].length(); j++)
      {
        char c = Str[i][j] - 'a';
        if (Jump[V][c] == -1)
        {
          Jump[V][c] = Vertex;
          Parent[Vertex++] = V;
        }
        if (j == (int)Str[i].length() - 1)
          End[V][c] = i;
        V = Jump[V][c];
      }
    }

  Pref[Root] = Root;
  for (int i = 0; i < Vertex; i++)
    CP(i);

  for (int i = 0; i < 26; i++)
    if (Jump[Root][i] == -1)
      Jump[Root][i] = Root;
  for (int i = 0; i < Vertex; i++)
    for (int j = 0; j < 26; j++)
    {
      if (Jump[i][j] == -1)
      {
        int Temp = i;
        while (Jump[Temp][j] == -1)
          Temp = Pref[Temp];
        Jump[i][j] = Jump[Temp][j];
      }
      int Temp = i;
      while (1)
      {
        if (End[Temp][j] != -1)
          Add[i][j] += Cost[End[Temp][j]];
        if (Temp == Root)
          break;
        Temp = Pref[Temp];
      };
    }

  memset(D, -1, sizeof(D));
  D[0][Root] = 0;
  for (int i = 0; i < N; i++)
    for (int j = 0; j < Vertex; j++)
      if (D[i][j] != -1)
        for (int k = 0; k < 26; k++)
          if (D[i + 1][Jump[j][k]] < D[i][j] + Add[j][k] ||
              D[i + 1][Jump[j][k]] == D[i][j] + Add[j][k] && Ret[i + 1][Jump[j][k]] > Ret[i][j] + (char)('a' + k))
          {
            D[i + 1][Jump[j][k]] = D[i][j] + Add[j][k];
            Ret[i + 1][Jump[j][k]] = Ret[i][j] + (char)('a' + k);
          }

  int Ans = -1;
  string Res;
  for (int i = 1; i < 26; i++)
    if (D[N][i] != -1)
      if (D[N][i] > Ans || D[N][i] == Ans && Ret[N][i] < Res)
      {
        Ans = D[N][i];
        Res = Ret[N][i];
      }

  printf("%d\n", Ans);
  printf("%s\n", Res.c_str());

  return 0;
}
