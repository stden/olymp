#include <cstdio>

char S[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!?";
char T[30000];
int tn;
char Code[255];
char rev6(int a)
{
  char res = 0;
  for (int i = 0; i < 6; i++)
    res <<= 1, res |= a & 1, a >>= 1;
  return res;
}

int n;

int is1( int i )
{
  return (T[i / 6] >> (5 - (i % 6))) & 1;
}

int ise( int a, int b )
{
  if (a == b)
    return 0;
  if (a > b)
    return !ise(b, a);
  return is1(n * (n - 1) / 2 - (n - 1 - a) * (n - a) / 2 + b - a - 1);
}


int dp[1 << 20][20];
#define was(code, a, b) (dp[code][a] & (1 << b))
#define set1(code, a, b) (dp[code][a] |= (1 << b))

int res[30][30], isr[30];

int t[30];

void dfs( int code, int a, int b )
{
  fprintf(stderr, "%d %d\n", a, b);
  if (a == b && tn)
  {
    if (!isr[tn])
    {  
      for (int i = 0; i < tn; i++)
        res[tn][i] = t[i];
      isr[tn] = 1;
    }
    return;
  }
  set1(code, a, b);
  for (int c = 0; c < n; c++)
    if (!(code >> c) & 1 && !was(code | (1 << c), a, c) && ise(b, c))
    {
      t[tn++] = c;
      dfs(code | (1 << c), a, c);
      tn--;
    }
}

int main( void )
{
  freopen("tourism.in", "rt", stdin);
  freopen("tourism.out", "wt", stdout);
  for (int i = 0; i <= 63; i++)
    Code[S[i]] = rev6(i);
  scanf("%d", &n);
  tn = (n * (n - 1)) / 2;

  tn = tn / 6 + ((tn % 6) != 0);

  while (getc(stdin) != '\n');
  for (int i = 0; i < tn; i++)
    T[i] = Code[getc(stdin)];
/*  for (int i = 0; i < n * (n - 1); i++)
    printf("%d", is1(i));
  printf("\n");
  for (int i = 0; i < n; i++)
  {
    for (int j = 0; j < n; j++)
      printf("%d", ise(i, j));
   printf("\n");
  }*/
  tn = 0;
  for (int i = 0; i < n; i++)
    dfs(0, i, i);
  
  int k;
  scanf("%d", &k);
  for (int i = 0; i < k; i++)
  {
    int b;
    scanf("%d", &b);
    if (b <= n && b > 0 && isr[b])
    {
      for (int j = 0; j < b; j++)
        printf("%d%c", res[b][j], j < b - 1 ? ' ' : '\n');
    }
    else
      printf("-1\n");
  }
  return 0;
}