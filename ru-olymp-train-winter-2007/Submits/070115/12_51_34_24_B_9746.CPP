#include <cstdio>
#include <cstdlib>
#include <cstring>

#define maxl 10002

int Was[maxl][2][2];

int Can( char *S, int l, int r, int lc, int rc )
{
  Was[l][lc][rc] = 1;
  for (;l <= r; l++, r--)
    for (lc = 0; lc < 2; lc++)
      for (rc = 0; rc < 2; rc++)
        if (Was[l][lc][rc])
        {
          if (l == r)
            if ((S[l] + 10 * lc - rc) >= 0 && ((S[l] + 10 * lc - rc) % 2 == 0) && (S[l] + 10 * lc - rc) <= 18)
              return 1;
          int ln = S[l] + 10 * lc, rn = S[r] - rc;
          if (l == r - 1)
          {
              int t;
              if ((t = ln * 10 + rn) >= 0 && t % 10 == t / 10)
                return 1;
          }
          for (int ld = 0; ld < 2; ld++)
            for (int rd = 0; rd < 2; rd++)
            {
              int lt = ln - ld, rt = rn + 10 * rd;
              if (lt == rt && lt >= 0 && rt <= 18 && !Was[l + 1][ld][rd])
                Was[l + 1][ld][rd] = 1;
            }
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
    int c;
    while ((c = getc(stdin)) < '0' || c > '9');
    int SN = 0;
    S[SN++] = c;
    while ((c = getc(stdin)) >= '0' && c <= '9')
      S[SN++] = c;
    int j = 0;
    while (S[j] == '0' && j < SN - 1)
      j++;
    SN -= j;
    for (int i = 0; i < SN; i++)
      S[i] = S[i + j];
    /*scanf("%s", S);
    int SN = strlen(S);*/
    if (SN == 1 && S[0] == '0')
      return 0;
    for (int i = 0; i < SN; i++)
      S[i] -= '0';
    if (SN == 1)
    {
      printf(S[0] & 1 ? "NO\n" : "YES\n");
      continue;
    }
    memset(Was, 0, sizeof(int) * 4 * (SN + 10));
    if (Can(S, 0, SN - 1, 0, 0))
    {
      printf("YES\n");
      continue;
    }
    S[0] *= 10;
    for (int i = 0; i < SN - 1; i++)
      S[i] += S[i + 1], S[i + 1] = 0;
    memset(Was, 0, sizeof(int) * 4 * (SN + 10));
    if (Can(S, 0, SN - 2, 0, 0))
    {
      printf("YES\n");
      continue;
    }
    printf("NO\n");

  }
}
                                                                                                  
