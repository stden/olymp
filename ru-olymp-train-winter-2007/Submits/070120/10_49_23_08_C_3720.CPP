#include <cstdio>
#include <cstring>

void CalcPrefix( char *S, int *P)
{
  P[0] = 0;
  int L = strlen(S);
  for (int i = 1; i < L; i++)
  {
    P[i] = P[i - 1];
    while (P[i] != 0 && S[P[i]] != S[i])
      P[i] = P[P[i] - 1];
    if (S[P[i]] == S[i])
      P[i]++;
  }
}

#define maxl 10000010

char S[50000 * 11], T[maxl];
int P[maxl];

int main( void )
{
  freopen("rle.in", "rt", stdin);
  freopen("rle.out", "wt", stdout);

  scanf("%s", S);
  int L = 0, N;
  for (int i = 0; S[i]; i++)
    if (S[i] >= '0' && S[i] <= '9')
    {
      int Temp = 0;
      for (; S[i] >= '0' && S[i] <= '9'; i++)
        Temp = Temp * 10 + S[i] - '0';
      for (int j = 0; j < Temp; j++)
        T[L++] = S[i];
    }
    else
      T[L++] = S[i];
  T[L] = 0;
  CalcPrefix(T, P);
  scanf("%d", &N);
  for (int i = 0; i < N; i++)
  {
    int a;
    scanf("%d", &a);
    printf("%d\n", P[a - 1]);
  }

  return 0;
}
