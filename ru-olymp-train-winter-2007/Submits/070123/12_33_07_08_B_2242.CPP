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



#define maxn 100010

int Q1[maxn], Q2[maxn], Ans[maxn], K1[maxn], K2[maxn], C1[maxn], C2[maxn];
vector <PII> V1[maxn], V2[maxn];

int main( void )
{
  freopen("omax.in", "rt", stdin);
  freopen("omax.out", "wt", stdout);

  int N;
  scanf("%d", &N);
  for (int i = 0; i < N; i++)
  {
    int K, b;
    scanf("%d", &K);
    V1[i].resize(K);
    for (int j = 0; j < K; j++)
    {
//      scanf("%d", &b), V1[i][j] = MP(b - 1, 0);
      scanf("%d", &b), V1[i][j] = MP(b - 1, V2[b - 1].size());
      V2[b - 1].PB(MP(i, j));
    }
  }
/*
  memset(K1, 0, sizeof(K1));
  memset(K2, 0, sizeof(K2));
  for (int i = 0; i < N; i++)
    for (int j = 0; j < V1[i].size(); i++)
      V1[i][j].SE = K1[V1[i][j].FI]++;
  for (int i = 0; i < N; i++)
    V2[i].resize(K1[i]);
  for (int i = 0; i < N; i++)
    for (int j = 0; j < V1[i].size(); i++)
      V2[V1[i][j].FI][K2[V1[i][j].FI]++].FI = i, V2[V1[i][j].FI][K2[V1[i][j].FI]++].SE = j;
*/

  int qs1 = 0, qs2 = 0, qz1 = 0, qz2 = 0;
  for (int i = 0; i < N; i++)
  {
    if (V1[i].size() == 1)
      Q1[qs1 + qz1++] = i;
    if (V2[i].size() == 1)
      Q2[qs2 + qz2++] = i;
  }

  fprintf(stderr, "BFS\n");
  memset(K1, 0, sizeof(K1));
  memset(K2, 0, sizeof(K2));
  memset(C1, 0, sizeof(C1));
  memset(C2, 0, sizeof(C2));
  memset(Ans, -1, sizeof(Ans));
  while (qz1 || qz1)
  {
    int T1 = -1, T2 = -1;
    if (qz1 >= qz2)
      T1 = Q1[qs1++], qz1--;
    else
      T2 = Q2[qs2++], qz2--;
    if (T1 != -1)
    {
      if (C1[T1])
        continue;
      if (V1[T1].size() == K1[T1])
        continue;
      T2 = V1[T1][K1[T1]].FI, Ans[T1] = T2;
      C1[T1] = C2[T2] = 1;
      for (int i = K2[T2]; i < V2[T2].size(); i++)
      {
        int t = V2[T2][i].FI;
        if (C1[t])
          continue;
        if (t != T1)
        {
          int x = V2[T2][i].SE;
          if (x >= K1[t])
          {
            swap(V1[t][x], V1[t][K1[t]]), K1[t]++;
            V2[V1[t][x].FI][V1[t][x].SE].SE = x;
            if (V1[t].size() - K1[t] == 1)
              Q1[qs1 + qz1++] = t;
          }
        }
      }
    }
    else
    {
      if (C2[T2])
        continue;
      if (V2[T2].size() == K2[T2])
        continue;
      T1 = V2[T2][K2[T2]].FI, Ans[T1] = T2;
      C1[T1] = C2[T2] = 1;
      for (int i = K1[T1]; i < V1[T1].size(); i++)
      {
        int t = V1[T1][i].FI;
        if (C2[t])
          continue;
        if (t != T2)
        {
          int x = V1[T1][i].SE;
          if (x >= K2[t])
          {
            swap(V2[t][x], V2[t][K2[t]]), K2[t]++;
            V1[V2[t][x].FI][V2[t][x].SE].SE = x;
            if (V2[t].size() - K2[t] == 1)
              Q2[qs2 + qz2++] = t;
          }
        }
      }
    }
  }

  int f = 1;
  for (int i = 0; i < N; i++)
    if (Ans[i] == -1)
      f = 0;

  if (f)
  {
    printf("YES\n");
    for (int i = 0; i < N; i++)
      printf("%d%c", Ans[i] + 1, i < N - 1 ? ' ' : '\n');
  }
  else
    printf("NO\n");

  return 0;
}
