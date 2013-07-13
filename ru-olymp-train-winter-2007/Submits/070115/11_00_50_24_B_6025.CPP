#include <cstdio>
#include <cstdlib>
#include <cstring>

#define maxl 10002

int Was[maxl][2][2];

int Can( char *S, int l, int r, int lc, int rc )
{
  Was[l][lc][rc] = 1;
  if (l == r)
    return (S[l] + 10 * lc - rc) >= 0 && ((S[l] + 10 * lc - rc) % 2 == 0) && (S[l] + 10 * lc - rc) <= 18;
  int ln = S[l] + 10 * lc, rn = S[r] - rc;
  if (l == r - 1)
  {
    for (int i = 0; i <= 9; i++)
      if (i * 10 + i == ln * 10 + rn)
        return 1;
  }
  for (int ld = 0; ld < 2; ld++)
    for (int rd = 0; rd < 2; rd++)
    {
      int lt = ln - ld, rt = rn + 10 * rd;
      if (lt == rt && lt >= 0 && rt <= 18 && !Was[l + 1][ld][rd] && Can(S, l + 1, r - 1, ld, rd))
        return 1;
    }
 return 0;
}
int main( void )
{
  char S[maxl];
  freopen("reverse.in", "rt", stdin);
  freopen("reverse.out", "wt", stdout);

  while (1)
  {
    scanf("%s", S);
    int SN = strlen(S);
    if (SN == 1 && S[0] == '0')
      return 0;
    for (int i = 0; i < SN; i++)
      S[i] -= '0';
    if (SN == 1)
    {
      printf(S[0] & 1 ? "NO\n" : "YES\n");
      continue;
    }
    memset(Was, 0, sizeof(Was));
    if (Can(S, 0, SN - 1, 0, 0))
    {
      printf("YES\n");
      continue;
    }
    S[0] *= 10;
    for (int i = 0; i < SN - 1; i++)
      S[i] += S[i + 1], S[i + 1] = 0;
    memset(Was, 0, sizeof(Was));
    if (Can(S, 0, SN - 2, 0, 0))
    {
      printf("YES\n");
      continue;
    }
    printf("NO\n");

  }
}
                                                                                                  
