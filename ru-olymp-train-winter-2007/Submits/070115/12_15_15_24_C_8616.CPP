#include <cstdio>
#include <cstring>

int Can[100001], Next[100001];

int S[100001];
int SN;

int main( void )
{
  freopen("bit.in", "rt", stdin);
  freopen("bit.out", "wt", stdout);

  int N;
  scanf("%d", &N);
  while (N--)
  {
    scanf("%d", &SN);
    while (getc(stdin) != '\n');
    for (int i = 0; i < SN; i++)
      S[i] = getc(stdin) - 'a';
    memset(Can, 0, sizeof(Can));
    Can[0] = 1;
    Next[SN - 1] = SN - 1;
    for (int i = SN - 2; i >= 0; i--)
      if (S[i] == S[i + 1])
        Next[i] = Next[i + 1];
      else
        Next[i] = i;

    for (int i = 0; i < SN; i++)
      if (Can[i])
      {
        fprintf(stderr, "%d\n", i);
        if (Next[i] + 1 < SN)
          Can[Next[i] + 2] = 1;
        if (i < SN - 1 && S[i] != S[i + 1])
          Can[Next[i + 1]]  = 1, Can[Next[i + 1] + 1] = 1;
      }
    printf(Can[SN] ? "YES\n" : "NO\n");

  }
  return 0;
}

