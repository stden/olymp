#include <cstdio>

#define maxl 200010

char S[maxl], S1[maxl];
int S2[maxl], K1, K2;

void Make( char c )
{
  int A = S2[--K2];
  int B = S2[--K2];
  int C;
  if (c == '+')
    C = A + B;
  else if (c == '-')
    C = B - A;
  else if (c == '*')
    C = A * B;
  S2[K2++] = C;
}

int main( void )
{
  freopen("expr.in", "rt", stdin);
  freopen("expr.out", "wt", stdout);

  int N = 0;
  char c;
  while (scanf(" %c", &c) == 1)
    S[N++] = c;
  S[N] = '\0';
  K1 = K2 = 0;
  for (int i = 0; i < N; i++)
  {
    if (S[i] == '+' || S[i] == '-')
    {
      while (K1 && (S1[K1 - 1] == '*' || S1[K1 - 1] == '+' || S1[K1 - 1] == '-'))
        K1--, Make(S1[K1]);
      S1[K1++] = S[i];
    }
    else if (S[i] == '*')
    {
      while (K1 && (S1[K1 - 1] == '*'))
        K1--, Make('*');
      S1[K1++] = '*';
    }
    else if (S[i] == '(')
      S1[K1++] = '(';
    else if (S[i] == ')')
    {
      while (K1 && (S1[K1 - 1] == '*' || S1[K1 - 1] == '+' || S1[K1 - 1] == '-'))
        K1--, Make(S1[K1]);
      if (S1[K1 - 1] == '(')
        K1--;
    }
    else
    {
      int j;
      int Temp = 0;
      for (j = i; j < N && S[j] >= '0' && S[j] <= '9'; j++)
        Temp = Temp * 10 + S[j] - '0';
      S2[K2++] = Temp;
      i = j - 1;
    }
  }
  for (; K1; K1--)
    if (S1[K1 - 1] == '*' || S1[K1 - 1] == '+' || S1[K1 - 1] == '-')
      Make(S1[K1 - 1]);
  printf("%u\n", S2[K2 - 1]);

  return 0;
}
