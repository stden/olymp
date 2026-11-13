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



int Get1( char c )
{
  if (c >= '0' && c <= '9')
    return c - '0';
  if (c >= 'A' && c <= 'Z')
    return c - 'A' + 10;
  if (c >= 'a' && c <= 'z')
    return c - 'a' + 36;
  if (c == '!')
    return 62;
  if (c == '?')
    return 63;
}

#define maxn 4010

int N, K, T[maxn], OldB[maxn], C[maxn], A[maxn];
short Ans[maxn][maxn];
char Temp[maxn * maxn / 6], D[maxn][maxn];
vector <PII> B;

int main( void )
{
  freopen("tourism.in", "rt", stdin);
  freopen("tourism.out", "wt", stdout);

  scanf("%d ", &N);
  gets(Temp);
  scanf("%d", &K);
  for (int i = 0; i < K; i++)
  {
    scanf("%d", &OldB[i]);
    B.PB(MP(OldB[i], i));
  }
  sort(B.begin(), B.end());
  int Offset = 0;
  memset(D, 0, sizeof(D));
  for (int i = 0; i < N; i++)
  {
    for (int j = i + 1; j < N; j++)
      if (Get1(Temp[(Offset + j - i - 1)/ 6]) & (1 << ((Offset + j - i - 1) % 6)))
        D[i][j] = 1;
      else
        D[j][i] = 1;
    Offset += N - i - 1;
  }

  int f = 0, k = 0;
  for (int i = 1; i < N && !f; i++)
    for (int j = i + 1; j < N && !f; j++)
      if (D[0][i] && D[i][j] && D[j][0])
        T[0] = 0, T[1] = i, T[2] = j, f = 1;
      else if (D[0][j] && D[j][i] && D[i][0])
        T[0] = 0, T[1] = j, T[2] = i, f = 1;

  if (f)
  {
    memset(C, 0, sizeof(C));
    for (int i = 0; i < 3; i++)
      C[T[i]] = 1;
    memset(Ans, -1, sizeof(Ans));
    for (int Len = 3; Len <= N; Len++)
    {
      for (; k < B.size() && B[k].FI < Len; k++)
        ;
      for (; k < B.size() && B[k].FI == Len; k++)
        for (int i = 0; i < Len; i++)
          Ans[B[k].SE][i] = T[i];
      if (Len >= N)
        break;
      f = 0;
      for (int i = 0; i < N && !f; i++)
        if (!C[i])
        {
          for (int j = 0; j < Len && !f; j++)
          {
            int k = j + 1;
            if (k == Len)
              k = 0;
            if (D[T[j]][i] && D[i][T[k]])
            {
              f = 1;
              for (int t = j + 1; t < Len; t++)
                T[t++] = T[t];
              T[j + 1] = i, C[i] = 1;
            }
          }
          A[i] = D[T[0]][i];
        }
      if (f)
        continue;
      for (int i = 0; i < N && !f; i++)
        if (!C[i] && A[i])
          for (int j = 0; j < N && !f; j++)
            if (!C[j] && j != i && !A[j] && D[i][j])
            {
              f = C[i] = C[j] = 1;
              C[T[Len - 1]] = 0;
              T[Len - 1] = i, T[Len] = j;
            }
    }
    for (int i = 0; i < K; i++)
      if (Ans[i][0] == -1)
        printf("-1\n");
      else
        for (int j = 0; j < OldB[i]; j++)
          printf("%d%c", Ans[i][j], j < OldB[i] - 1 ? ' ' : '\n');
  }
  else
    for (int i = 0; i < K; i++)
      printf("-1\n");

  return 0;
}
