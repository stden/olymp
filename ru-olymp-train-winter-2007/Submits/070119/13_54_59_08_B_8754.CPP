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


#define maxn 210

int D[maxn][maxn], G[maxn][maxn][maxn], Temp[maxn][maxn];

int main( void )
{
  freopen("optimum.in", "rt", stdin);
  freopen("optimum.out", "wt", stdout);

  int N, M, P;
  scanf("%d%d%d", &N, &M, &P);
  memset(D, 0, sizeof(D));
  for (int i = 0; i < M; i++)
  {
    int a, b;
    scanf("%d%d", &a, &b);
    D[min(a, b) - 1][max(a, b) - 1]++;
  }

  memset(G, 0, sizeof(G));
  for (int i = 0; i < N; i++)
    for (int j = 0; j < N; j++)
      G[i][j][0] = 1;

  for (int Z = 0; Z < N - 1; Z++)
  {
//    fprintf(stderr, "i = %d\n", Z);
    int T1 = N - 1 - Z;
    int T2 = T1 - 1;
    int T3;
    memset(Temp, 0, sizeof(Temp));
    for (int k = 0; k <= D[T2][T1]; k++)
      for (int t = 0; t < N && k + t < N; t++)
        for (int i = 1; i < N; i++)
          if (G[T1][i][t])
            for (int j = 1; j < N && (T3 = i + j - k - k) < N; j++)
              if (T3 >= 0 && k <= i && k <= j && G[T2][j][0])
              {
//                fprintf(stderr, "  k = %d (i = %d, j = %d) -> %d\n", k, i, j, T3);
                Temp[T3][t + k] += G[T1][i][t] * G[T2][j][0];
                if (Temp[T3][t + k] >= P)
                  Temp[T3][t + k] %= P;
              }
    for (int i = 0; i < N; i++)
    {
      D[i][T2] += D[i][T1];
      if (D[i][T2] >= P)
        D[i][T2] %= P;
    }
    for (int i = 0; i < N; i++)
      for (int j = 0; j < N; j++)
        G[T2][i][j] = Temp[i][j];

/*
    fprintf(stderr, "  D[i][j]:\n");
    for (int i = 0; i < N; i++)
    {
      fprintf(stderr, "    [");
      for (int j = 0; j < N; j++)
        fprintf(stderr, "%d%s", D[i][j], j < N - 1 ? ", " : "");
      fprintf(stderr, "]\n");
    }
    fprintf(stderr, "\n");

    fprintf(stderr, "  G[i][j]:\n");
    for (int i = 0; i < N; i++)
    {
      fprintf(stderr, "    [");
      for (int j = 0; j < N; j++)
        fprintf(stderr, "%d%s", G[i][j], j < N - 1 ? ", " : "");
      fprintf(stderr, "]\n");
    }
    fprintf(stderr, "\n");
*/

  }

  printf("%d\n", G[0][0][N - 1]);

  return 0;
}
