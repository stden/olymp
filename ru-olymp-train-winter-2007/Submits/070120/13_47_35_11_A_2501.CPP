#include <algorithm>
#include <vector>
#include <cstdio>
#include <cstring>
#include <string>

using namespace std;

typedef long long llong;
typedef pair <int, int> PII;
typedef vector <int> VI;
typedef vector <string> VS;
typedef vector <PII> VPII;

#define F first
#define S second
#define PB push_back
#define MP make_pair

#define m 10100
#define ml 110
#define mm 26

char s[m];
int to[m][mm], nu, p[m], pa[m], pc[m], n, l, d[m], fp[ml][m], fc[ml][m];
llong co[m], f[ml][m];
VI li[m];

void add( int v, const char *s, int c, int de )
{
  if (!*s)
    co[v] += c;
  else
  {
    if (to[v][*s - 'a'] == -1)
      pa[nu] = v, pc[nu] = *s - 'a', d[nu] = de + 1, to[v][*s - 'a'] = nu++;
    add(to[v][*s - 'a'], s + 1, c, de + 1);
  }
}

int main( void )
{
  freopen("beauty.in", "rt", stdin);
  freopen("beauty.out", "wt", stdout);
  scanf("%d", &n);
  nu = 1;
  memset(to, -1, sizeof(to));
  vector <pair <string, int> > ss(n);
  for (int i = 0; i < n; i++)
    scanf("%s%d", s, &ss[i].S), ss[i].F = string(s);
//  sort(ss.begin(), ss.end());
  for (int i = 0; i < n; i++)
    add(0, ss[i].F.c_str(), ss[i].S, 0);
  scanf("%d", &l);
  for (int i = 0; i < nu; i++)
    li[d[i]].PB(i);
  p[0] = -1;
/*  for (int i = 0; i < nu; i++)
    for (int c = 0; c < 3; c++)
      printf("%d%c", to[i][c], (c == 3 - 1) ? '\n' : '\t');*/
  for (int i = 1; i <= nu; i++)
    for (int j = 0; j < li[i].size(); j++)
    {
      int v = li[i][j], pr = p[pa[v]], c = pc[v];
      while (pr != -1 && to[pr][c] == -1)
        pr = p[pr];
      if (pr == -1)
        p[v] = 0;
      else if (to[pr][c] != -1)
        p[v] = to[pr][c];
      co[v] += co[p[v]];
    }
/*  for (int i = 0; i < nu; i++)
    printf("p[%d]=%d co[%d]=%Ld\n", i, p[i], i, co[i]);*/
  for (int i = 0; i <= nu; i++)
    for (int j = 0; j < li[i].size(); j++)
      for (int c = 0; c < mm; c++)
      {
        int v = li[i][j], pr = v;
        if (to[v][c] != -1)
          continue;
        while (pr != -1 && to[pr][c] == -1)
          pr = p[pr];
        if (pr == -1 || to[pr][c] == -1)
          to[v][c] = 0;
        else
          to[v][c] = to[pr][c];
      }
/*  for (int i = 0; i < nu; i++)
    for (int c = 0; c < 3; c++)
      printf("%d%c", to[i][c], (c == 3 - 1) ? '\n' : '\t');*/
  memset(f, -1, sizeof(f));
  f[0][0] = 0;
  for (int i = 0; i < l; i++)
    for (int j = 0; j < nu; j++)
      if (f[i][j] != -1)
        for (int c = 0; c < mm; c++)
          if (f[i + 1][to[j][c]] < f[i][j] + co[to[j][c]])
            f[i + 1][to[j][c]] = f[i][j] + co[to[j][c]], fp[i + 1][to[j][c]] = j, fc[i + 1][to[j][c]] = c;
  llong ans = 0;
  for (int j = 0; j < nu; j++)
    ans >?= f[l][j];
  printf("%Ld\n", ans);
  for (int j = 0; j < nu; j++)
    if (f[l][j] != ans)
      f[l][j] = -1;
  for (int i = l - 1; i >= 0; i--)
    for (int j = 0; j < nu; j++)
      if (f[i][j] != -1)
      {
        int ff = 0;
        for (int c = 0; c < mm; c++)
          if (f[i + 1][to[j][c]] == f[i][j] + co[to[j][c]])
            ff = 1;
        if (!ff)
          f[i][j] = -1;
      }
  int jj = 0;
  for (int i = 0; i < l; i++)
  {
    for (int c = 0; c < mm; c++)
      if (f[i + 1][to[jj][c]] == f[i][jj] + co[to[jj][c]])
      {
        jj = to[jj][c];
        putc(c + 'a', stdout);
        break;
      }
  }
  return 0;
}
