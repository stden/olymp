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

#define SQR(X) ((X) * (X))


#define maxn 210

int A[maxn];
char D[maxn][maxn][maxn], P[maxn][maxn][maxn];

int main( void )
{
  freopen("change.in", "rt", stdin);
  freopen("change.out", "wt", stdout);

  int N, S = 0;
  scanf("%d", &N);
  for (int i = 0; i < N; i++)
    scanf("%d", &A[i]), S += A[i];

  memset(D, 0, sizeof(D));
  D[0][0][0] = 1;
  for (int i = 0; i < N; i++)
    for (int j = 0; j < 201; j++)
      for (int k = 0; k < 201; k++)
        if (D[i][j][k])
        {
          D[i + 1][j][k] = 1, P[i + 1][j][k] = 2,
          D[i + 1][j + A[i]][k] = 1, P[i + 1][j + A[i]][k] = 0,
          D[i + 1][j][k + A[i]] = 1, P[i + 1][j][k + A[i]] = 1;
        }

  int Ans = -1, tj = -1, tk = -1;
  for (int i = 0; i < 201; i++)
    for (int j = 0; j < 201; j++)
      if (D[N][i][j] && (Ans == -1 || Ans > SQR(3 * i - S) + SQR(3 * j - S) + SQR(2 * S - 3 * (i + j))))
        Ans = SQR(3 * i - S) + SQR(3 * j - S) + SQR(2 * S - 3 * (i + j)),
        tj = i, tk = j;
  int ti = N;
  VI V1, V2, V3;
  while (ti)
  {
    if (P[ti][tj][tk] == 0)
      V1.PB(A[ti - 1]), tj -= A[ti - 1];
    else if (P[ti][tj][tk] == 1)
      V2.PB(A[ti - 1]), tk -= A[ti - 1];
    else if (P[ti][tj][tk] == 2)
      V3.PB(A[ti - 1]);
    ti--;
  }
  sort(V1.begin(), V1.end());
  printf("%d", V1.size());
  for (int i = 0; i < V1.size(); i++)
    printf(" %d", V1[i]);
  printf("\n");     
  sort(V2.begin(), V2.end());
  printf("%d", V2.size());
  for (int i = 0; i < V2.size(); i++)
    printf(" %d", V2[i]);
  printf("\n");
  sort(V3.begin(), V3.end());
  printf("%d", V3.size());
  for (int i = 0; i < V3.size(); i++)
    printf(" %d", V3[i]);
  printf("\n");

  return 0;
}
