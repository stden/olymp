#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <map>
#include <set>
#include <utility>
#include <vector>

using namespace std;

#define PB push_back
#define MP make_pair
#define FI first
#define SE second

typedef vector <int> VI;
typedef pair <int, int> PII;


#define maxn 100010

VI V1[maxn], V2[maxn], R2[maxn], Col1[maxn], Col2[maxn], Res1, Res2;
int Time = 0, P[maxn], C[maxn], Co[maxn], Index[maxn];

void dfs1( int u )
{
  C[u] = 1;
  for (int i = 0; i < (int)V1[u].size(); i++)
    if (!C[V1[u][i]])
      dfs1(V1[u][i]);
  P[Time++] = u;
}

void dfs2( int u, int Color )
{
  C[u] = 1;
  Co[u] = Color;
  for (int i = 0; i < (int)V1[u].size(); i++)
    if (!C[V1[u][i]])
      dfs2(V1[u][i], Color);
}

void dfs3( int u, int Color )
{
  C[u] = Color;
  for (int i = 0; i < (int)V2[u].size(); i++)
    if (C[V2[u][i]] == -1)
      dfs3(V2[u][i], Color);
  for (int i = 0; i < (int)R2[u].size(); i++)
    if (C[R2[u][i]] == -1)
      dfs3(R2[u][i], Color);
}

int main( void )
{
  freopen("republic.in", "rt", stdin);
  freopen("republic.out", "wt", stdout);

//  fprintf(stderr, "reading...");
  int N, M;
  scanf("%d%d", &N, &M);
  for (int i = 0; i < M; i++)
  {
    int a, b;
    scanf("%d%d", &a, &b);
    V1[a - 1].PB(b - 1);
  }
//  fprintf(stderr, "%c%c%c [OK]\n", 8, 8, 8);

//  fprintf(stderr, "dfs1...");
  memset(C, 0, sizeof(C));
  for (int i = 0; i < N; i++)
    if (!C[i])
      dfs1(i);
//  fprintf(stderr, "%c%c%c [OK]\n", 8, 8, 8);

//  fprintf(stderr, "dfs2...");
  memset(C, 0, sizeof(C));
  int Color = 0;
  for (int i = 0; i < N; i++)
    if (!C[P[i]])
      dfs2(P[i], Color++);
  int N2 = Color;
//  fprintf(stderr, "%c%c%c [OK]\n", 8, 8, 8);

//  fprintf(stderr, "condensate...");
  for (int i = 0; i < N; i++)
  {
    Index[Co[i]] = i + 1;
    for (int j = 0; j < (int)V1[i].size(); j++)
      V2[Co[i]].PB(Co[V1[i][j]]), R2[Co[V1[i][j]]].PB(Co[i]);
  }
//  fprintf(stderr, "%c%c%c [OK]\n", 8, 8, 8);

/*
  fprintf(stderr, "\nG = %d %d\n", N2, M);
  for (int i = 0; i < N2; i++)
    for (int j = 0; j < (int)V2[i].size(); j++)
      fprintf(stderr, "%d %d\n", i + 1, V2[i][j] + 1);
  fprintf(stderr, "\n");
*/

//  fprintf(stderr, "dfs3...");
  memset(C, -1, sizeof(C));
  int Color2 = 0;
  for (int i = 0; i < N2; i++)
    if (C[i] == -1)
      dfs3(i, Color2++);
//  fprintf(stderr, "%c%c%c [OK]\n", 8, 8, 8);

/*
  fprintf(stderr, "C[] = {");
  for (int i = 0; i < N2; i++)
    fprintf(stderr, "%d%s", C[i], i < N2 - 1 ? ", " : "}\n");
*/

//  fprintf(stderr, "searching...");
  for (int i = 0; i < N2; i++)
  {
    if (V2[i].size() == 0)
      Col2[C[i]].PB(i);
    if (R2[i].size() == 0)
      Col1[C[i]].PB(i);
  }
//  fprintf(stderr, "%c%c%c [OK]\n", 8, 8, 8);

/*
  for (int i = 0; i < Color2; i++)
  {
    fprintf(stderr, "Col1[i = %d] = {", i);
    for (int j = 0; j < (int)Col1[i].size(); j++)
      fprintf(stderr, "%d%s", Col1[i][j], j < (int)Col1[i].size() - 1 ? ", " : "");
    fprintf(stderr, "}\n");
    fprintf(stderr, "Col2[i = %d] = {", i);
    for (int j = 0; j < (int)Col2[i].size(); j++)
      fprintf(stderr, "%d%s", Col2[i][j], j < (int)Col2[i].size() - 1 ? ", " : "");
    fprintf(stderr, "}\n");
  }
*/

  vector <PII> Answer(0);
  int UpV = -1, DoV = -1;

//  fprintf(stderr, "connect...");
  if (Color2 > 1)
    for (int i = 0; i < Color2; i++)
    {
      int j = (i + 1) % Color2;
      Answer.PB(MP(Index[Col2[i][(int)Col2[i].size() - 1]], Index[Col1[j][(int)Col1[j].size() - 1]]));
      UpV = Index[Col1[j][(int)Col1[j].size() - 1]];
      DoV = Index[Col2[i][(int)Col2[i].size() - 1]];
      Col2[i].resize(Col2[i].size() - 1);
      Col1[j].resize(Col1[j].size() - 1);
    }
//  fprintf(stderr, "%c%c%c [OK]\n", 8, 8, 8);

//  fprintf(stderr, "remake...");
  for (int i = 0; i < Color2; i++)
  {
    for (int j = 0; j < (int)Col1[i].size(); j++)
      Res1.PB(Col1[i][j]);
    for (int j = 0; j < (int)Col2[i].size(); j++)
      Res2.PB(Col2[i][j]);
  }
//  fprintf(stderr, "%c%c%c [OK]\n", 8, 8, 8);

/*
  fprintf(stderr, "Res1 = {");
  for (int j = 0; j < (int)Res1.size(); j++)
    fprintf(stderr, "%d%s", Res1[j], j < (int)Res1.size() - 1 ? ", " : "");
  fprintf(stderr, "}\n");
  fprintf(stderr, "Res2 = {");
  for (int j = 0; j < (int)Res2.size(); j++)
    fprintf(stderr, "%d%s", Res2[j], j < (int)Res2.size() - 1 ? ", " : "");
  fprintf(stderr, "}\n");
*/

//  fprintf(stderr, "generate...");
  int N3 = (int)max(Res1.size(), Res2.size());
  for (int i = 0; i < N3; i++)
  {
//    fprintf(stderr, "\ni = %d of %d", i, (int)max(Res1.size(), Res2.size()));
    int T1, T2;
    if (Res1.size())
      T1 = Index[Res1[Res1.size() - 1]], Res1.resize(Res1.size() - 1);
    else
      T1 = UpV;
    if (Res2.size())
      T2 = Index[Res2[Res2.size() - 1]], Res2.resize(Res2.size() - 1);
    else
      T2 = DoV;
    UpV = T1, DoV = T2;
//    fprintf(stderr, "\ni = %d, T1 = %d, T2 = %d\n", i, T1, T2);
    if (T1 != T2)
      Answer.PB(MP(T2, T1));
  }
//  fprintf(stderr, "%c%c%c [OK]\n", 8, 8, 8);

//  fprintf(stderr, "writing...");
  printf("%d\n", (int)Answer.size());
  for (int i = 0; i < (int)Answer.size(); i++)
    printf("%d %d\n", Answer[i].FI, Answer[i].SE);
//  fprintf(stderr, "%c%c%c [OK]\n", 8, 8, 8);

  return 0;
}
