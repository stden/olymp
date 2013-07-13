#include <cstdio>
#include <cstring>

#define maxl 10010

char S1[maxl], S2[maxl];
char D[maxl][maxl / 8];

int main( void )
{
  freopen("patterns.in", "rt", stdin);
  freopen("patterns.out", "wt", stdout);

  scanf("%s%s", S1, S2);
  memset(D, 0, sizeof(D));
  D[0][0] = 1;
  for (int i = 0; S1[i]; i++)
    for (int j = 0; S2[j]; j++)
      if (D[i][j >> 3] & (1 << (j & 7)))
      {
        if (S1[i] == '*')
          D[i][(j + 1) >> 3] |= (1 << ((j + 1) & 7)),
          D[i + 1][j >> 3] |= (1 << (j & 7));
        if (S1[i] == '?' || S1[i] == S2[j])
          D[i + 1][(j + 1) >> 3] |= (1 << ((j + 1) & 7));
      }

  if (D[strlen(S1)][strlen(S2) >> 3] & (1 << ((strlen(S2)) & 7)))
    printf("YES\n");
  else
    printf("NO\n");

  return 0;
}
