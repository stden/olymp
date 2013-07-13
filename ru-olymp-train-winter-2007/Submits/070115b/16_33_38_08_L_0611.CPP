#include <cstdio>

#define maxl 300010
char S[maxl];
int P[maxl];

int main( void )
{
  freopen("substr.in", "rt", stdin);
  freopen("substr.out", "wt", stdout);

  int N = 0;
  char c;
  while (scanf(" %c", &c) == 1)
    S[N++] = c;

  P[0] = 0;
  for (int i = 1; i < N; i++)
  {
    P[i] = P[i - 1];
    while (P[i] != 0 && S[P[i]] != S[i])
      P[i] = P[P[i] - 1];
    if (S[P[i]] == S[i])
      P[i]++;
  }

/*
  for (int i = 0; i < N; i++)
    fprintf(stderr, "%c", S[i]);
  fprintf(stderr, "\n");
  for (int i = 0; i < N; i++)
    fprintf(stderr, "%d", P[i]);
  fprintf(stderr, "\n");
*/

  int pos, i;
  for (pos = 0; pos < N && S[pos] != '*'; pos++)
    ;
  for (i = 0; i < N; i++)
    if (P[i] == pos)
      printf("%d\n", i - 2 * pos + 1);

  return 0;
}
