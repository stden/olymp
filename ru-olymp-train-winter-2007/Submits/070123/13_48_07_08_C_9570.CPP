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

#define maxn 4040

int N, K, T[maxn], OldB[maxn], C[maxn / 32], A[maxn], Temp[maxn / 32], A2[maxn / 32];
short Ans[maxn][maxn];
char Temp1[maxn * maxn / 6];
int DN[maxn][maxn / 32], DT[maxn][maxn / 32];
vector <PII> B;

int main( void )
{
  freopen("tourism.in", "rt", stdin);
  freopen("tourism.out", "wt", stdout);

  scanf("%d ", &N);
  gets(Temp1);
  scanf("%d", &K);
  for (int i = 0; i < K; i++)
  {
    scanf("%d", &OldB[i]);
    B.PB(MP(OldB[i], i));
  }
  sort(B.begin(), B.end());
  int Offset = 0;
  memset(DN, 0, sizeof(DN));
  memset(DT, 0, sizeof(DT));
  for (int i = 0; i < N; i++)
  {
    for (int j = i + 1; j < N; j++)
      if (Get1(Temp1[(Offset + j - i - 1)/ 6]) & (1 << ((Offset + j - i - 1) % 6)))
        DN[i][j >> 5] |= 1 << (j & 31), DT[j][i >> 5] |= 1 << (i & 31);
      else
        DN[j][i >> 5] |= 1 << (i & 31), DT[i][j >> 5] |= 1 << (j & 31);
    Offset += N - i - 1;
  }

  int f = 0, k = 0;
  for (int i = 1; i < N && !f; i++)
    if (DN[0][i >> 5] & (1 << (i & 31)))
    for (int j = 1; j < N && !f; j++)
      if (i != j)
        if ((DN[i][j >> 5] & (1 << (j & 31))) && (DN[j][0] & 1))
          T[0] = 0, T[1] = i, T[2] = j, f = 1;

  if (f)
  {
    memset(C, 0, sizeof(C));
    memset(A, 0, sizeof(A));
    for (int i = 0; i < 3; i++)
      C[T[i] >> 5] |= 1 << (i & 31);
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
        if (!(C[i >> 5] & (1 << (i & 31))))
        {
          for (int j = 0; j < ((N + 31) >> 5); j++)
            Temp[j] = C[j] & DT[i][j];
          for (int j = 0; j < ((N + 31) >> 5)&& !f; j++)
            if (Temp[j] != 0)
              f = 1;
          if (!f)
          {
            A[i] = 0;
            continue;
          }
          f = 0;
          for (int j = 0; j < ((N + 31) >> 5)&& !f; j++)
            if (Temp[j] != C[j])
              f = 1;
          if (!f)
          {
            A[i] = 1;
            continue;
          }
          if (!f)
            continue;
          for (int j = 0; j < Len; j++)
          {
            int t = j + 1;
            if (t == Len)
              t = 0;
            if (DN[T[j]][i >> 5] & DT[T[t]][i >> 5] & (1 << (i & 31)))
            {
              for (int x = Len - 1; x > j; x--)
                T[x + 1] = T[x];
              T[j + 1] = i, C[i >> 5] |= 1 << (i & 31), A[i] = 0;
              break;
            }
          }
        }
      if (f)
        continue;
      memset(A2, 0, sizeof(A2));
      for (int i = 0; i < N; i++)
        A2[i >> 5] |= A[i] << (i & 31);

      for (int j = 0; j < N && !f; j++)
        if (!A[j] && (!(C[j >> 5] & (1 << (j & 31)))))
        {
          for (int i = 0; i < ((N + 31) >> 5); i++)
            Temp[i] = A2[i] & DT[j][i];
          for (int i = 0; i < ((N + 31) >> 5) && !f; i++)
            if (Temp[i] != 0)
            {
              int Tmp = Temp[i];
              i = i << 5;
              for (; (Tmp & (1 << (i & 31))) == 0; i++)
                ;
              f = 1, A[i] = A[j] = 0;
              C[i >> 5] |= 1 << (i & 31);
              C[j >> 5] |= 1 << (j & 31);
              C[T[Len - 1] >> 5] &= ~(1 << (T[Len - 1] & 31));
              T[Len - 1] = i, T[Len] = j;
            }
        }
      if (!f)
        break;
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
