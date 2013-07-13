#include <cstdio>
#include <cstring>

char S1[20000], S2[20000];
int Can[2][20000], N1, N2, Can1[2][20000];

int main( void )
{
  freopen("patterns.in", "rt", stdin);
  freopen("patterns.out", "wt", stdout);

  scanf("%s%s", S1, S2);
  int now = 0, next;
  N1 = strlen(S1);
  N2 = strlen(S2);
  Can[now][0] = 1;
  Can1[now][0] = 1;
  for (int i = 1; i <= N1; i++)
  {
    next = 1 - now;
    for (int j = 1; j <= N2; j++)
    {
      if (S1[i - 1] == '?')
        Can[next][j] = Can[now][j - 1];
      else if (S1[i - 1] == '*')
        Can[next][j] = Can1[now][j];
      else if (S1[i - 1] == S2[j - 1])
        Can[next][j] = Can[now][j - 1];
      Can1[next][j] = Can1[next][j - 1] | Can[next][j];
    }
    now = next;
    memset(Can[1 - now], 0, sizeof(Can[1 - now]));
    memset(Can1[1 - now], 0, sizeof(Can1[1 - now]));
  }
  if (Can[now][N2])
    printf("YES\n");
  else
    printf("NO\n");
  return 0;              
}