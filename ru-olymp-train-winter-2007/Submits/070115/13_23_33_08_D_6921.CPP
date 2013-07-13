#include <cstdio>
#include <cstring>

#define maxk 6
#define maxn 210
#define maxp 1000010

int A[maxk][maxn];
char D[maxp];
int Q[maxp];

int main( void )
{
  freopen("bit2.in", "rt", stdin);
  freopen("bit2.out", "wt", stdout);

  int T;
  scanf("%d", &T);
  while (T--)
  {
    int N, K;
    scanf("%d%d", &N, &K);
    for (int i = 0; i < K; i++)
      for (int j = 0; j < N; j++)
        scanf("%d", &A[i][j]);
    if (N > 20)
    {
      printf("NO\n");
      continue;
    }
    memset(D, 0, sizeof(D));
    int qs, qz;
    qs = qz = 0;
    D[(1 << N) - 1] = 1, Q[qs + qz++] = (1 << N) - 1;
    while (qz && !D[1])
    {
      int T = Q[qs++]; qz--;
      for (int i = 0; i < K; i++)
      {
        int R = 0;
        for (int j = 0; j < N; j++)
          if (T & (1 << j))
            R = R | (1 << A[i][j]);
        if (!D[R])
          D[R] = 1, Q[qs + qz++] = R;
      }
    }
    if (D[1])
      printf("YES\n");
    else
      printf("NO\n");
  }

  return 0;
}
