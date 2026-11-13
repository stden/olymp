#include <cstdio>

int Cnt[101][101];

int main( void )
{
  int i, j, k;

  freopen("part.in", "rt", stdin);
  freopen("part.out", "wt", stdout);
  for (int i = 0; i <= 100; i++)
    Cnt[0][i] = 1;
  for (int i = 1; i <= 100; i++)
  {
    Cnt[i][0] = 0;
    for (int a = 1; a <= 100; a++)
    {
      Cnt[i][a] = Cnt[i][a - 1]; 
      if (i >= a)
        Cnt[i][a] += Cnt[i - a][a];
    }
  }
  int n, cnt, lm;
  while (scanf("%d%d", &n, &cnt) == 2 && (n || cnt))
  {
    lm = n;
    cnt++;
    while (n > 0)
    {
      int i = lm;
      while (Cnt[n][lm] - Cnt[n][i - 1] < cnt)
        i--;
//      fprintf(stderr, "i = %d\n", i);
      printf("%d ", i);
      cnt -= Cnt[n][lm] - Cnt[n][i];
      n -= i;
      lm = i;
/*      fprintf(stderr, "n = %d\n", n);
      fprintf(stderr, "cnt = %d\n", cnt);
      fprintf(stderr, "lm = %d\n", lm);*/
    }
    printf("\n");
  }
  return 0;
}
