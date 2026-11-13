#include <cstdio>

#define maxn 200001



int isop[maxn], op[maxn], num[maxn], N, S1N, S2N, S[maxn], SN, S2[maxn];
long long S1[maxn], modul;

int GetP( int c )
{
  switch (c)
  {
  case '(':
    return 0;
  case ')':
    return 1;
  case '+':
  case '-':
    return 2;
  case '*':
    return 3;
  }
}

void drop( int p )
{
  while (S2N && GetP(S2[S2N - 1]) >= p)
  {
    switch (S2[S2N - 1])
    {
    case '+':
      S1[S1N - 2] = (S1[S1N - 2] + S1[S1N - 1]) % modul;
      break;
    case '-':
      S1[S1N - 2] = (S1[S1N - 2] - S1[S1N - 1]) % modul;
      break;
    case '*':
      S1[S1N - 2] = (S1[S1N - 2] * S1[S1N - 1]) % modul;
      break;
    }
    S1N--;
    S2N--;
  }
}

int main( void )
{
  freopen("expr.in", "rt", stdin);
  freopen("expr.out", "wt", stdout);
  int c;
  while ((c = getc(stdin)) != '\n' && c != -1)
    S[SN++] = c;
  int i = 0;
  while (i < SN)
  {
    c = S[i];
    if (c >= '0' && c <= '9')
    {
      int numn = 0;
      while (i < SN && S[i] >= '0' && S[i] <= '9')
        numn *= 10, numn += S[i] - '0', i++;
      num[N++] = numn;
    }
    else
    {
      isop[N] = 1;
      op[N++] = c;
      i++;
    }
  }
  for (i = 0; i < N; i++)
    if (isop[i])
      fprintf(stderr, "%c", (char)op[i]);
    else
      fprintf(stderr, "%d", num[i]);
  modul = 1 << 30;
  modul *= 4;
  for (i = 0; i < N; i++)
  {
    if (isop[i])
    {
      if (op[i] != '(')
        drop(GetP(op[i]));
      if (op[i] == ')')
        S2N--;
      else
        S2[S2N++] = op[i];
    }
    else
      S1[S1N++] = num[i];
  }
  drop(-1);
  if (S1[0] < 0)
    S1[0] += modul;
  printf("%I64d\n", S1[0]);
  return 0;
}