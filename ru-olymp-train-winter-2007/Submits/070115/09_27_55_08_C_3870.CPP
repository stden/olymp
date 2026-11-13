#include <cstdio>

#define maxn 100010

char S[maxn];

int main( void )
{
  freopen("bit.in", "rt", stdin);
  freopen("bit.out", "wt", stdout);

  int T;
  scanf("%d", &T);
  while (T--)
  {
    int N;
    scanf("%d", &N);
    for (int i = 0; i < N; i++)
      scanf(" %c", &S[i]);
    if (N == 1)
      printf("NO\n");
    else if (S[0] != S[1] || S[N - 1] != S[N - 2])
      printf("YES\n");
    else
    {
      int f = 0;
      for (int i = 1; i < N - 2 && !f; i++)
        if (S[i - 1] != S[i] && S[i + 1] != S[i + 2])
          f = 1;
      if (f)
        printf("YES\n");
      else
        printf("NO\n");
    }
  }

  return 0;
}
