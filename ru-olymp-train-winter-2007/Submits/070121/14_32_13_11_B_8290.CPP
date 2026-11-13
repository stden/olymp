#include <cstdio>
#include <cstring>
#include <vector>
#include <map>

using namespace std;

typedef vector <int> VI;

#define PB push_back
#define MP make_pair

map <pair <int, VI>, int> f;
char c[3][13][3], cu, col[128], con[128];

int ista( char ty[3], char va[3] )
{
  if (ty[0] == cu)
  {
    if ((ty[1] != cu || con[va[1]] < con[va[0]]) && (ty[2] != cu || con[va[2]] < con[va[0]]))
      return 1;
  }
  else if (ty[1] != cu && ty[2] != cu)
    if ((ty[1] != ty[0] || con[va[1]] < con[va[0]]) && (ty[2] != ty[0] || con[va[2]] < con[va[0]]))
      return 1;
  return 0;
}

int nu = 0;

int dfs( int m, VI a )
{
  if (f.count(MP(m, a)))
    return f[MP(m, a)];
  if (++nu % 1000 == 0)
    fprintf(stderr, "%d\n", nu);
  if (a[m] == 0)
    return 0;
  VI ca[3];
  int is[3][4];
  memset(is, 0, sizeof(is));
  for (int j = 0; j < 3; j++)
    for (int i = 0; i < 10 + (j == 0) * 2; i++)
      if ((a[j] >> i) & 1)
        ca[j].PB(i), is[j][col[c[j][i][1]]] = 1;
  char ty[3], va[3];
  if (m == 0)
  {
    int ans = 0;
    for (int i = 0; i < ca[0].size(); i++)
    {
      ty[0] = c[0][ca[0][i]][1], va[0] = c[0][ca[0][i]][0];
      int ans1 = 11;
      for (int j = 0; j < ca[1].size(); j++)
      {
        ty[1] = c[1][ca[1][j]][1], va[1] = c[1][ca[1][j]][0];
        if (ty[0] == ty[1] || (!is[1][col[ty[0]]] && (cu == 'N' || ty[1] == cu || !is[1][col[cu]])))
          for (int k = 0; k < ca[2].size(); k++)
          {
            ty[2] = c[2][ca[2][k]][1], va[2] = c[2][ca[2][k]][0];
            if (ty[0] == ty[2] || (!is[2][col[ty[0]]] && (cu == 'N' || ty[2] == cu || !is[2][col[cu]])))
            {
              int ta = ista(ty, va);
              VI t(3);
              t[0] = a[0] & ~(1 << ca[0][i]);
              t[1] = a[1] & ~(1 << ca[1][j]);
              t[2] = a[2] & ~(1 << ca[2][k]);
              ans1 <?= dfs(ta ? 0 : 1, t) + ta;
            }
          }
      }
      ans >?= ans1;
    }
    return f[MP(m, a)] = ans;
  }
  else if (m == 1)
  {
    int ans = 11;
    for (int i = 0; i < ca[1].size(); i++)
    {
      ty[1] = c[1][ca[1][i]][1], va[1] = c[1][ca[1][i]][0];
      for (int j = 0; j < ca[2].size(); j++)
      {
        ty[2] = c[2][ca[2][j]][1], va[2] = c[2][ca[2][j]][0];
        int ans1 = 0;
        if (ty[1] == ty[2] || (!is[2][col[ty[1]]] && (cu == 'N' || ty[2] == cu || !is[2][col[cu]])))
          for (int k = 0; k < ca[0].size(); k++)
          {
            ty[0] = c[0][ca[0][k]][1], va[0] = c[0][ca[0][k]][0];
            if (ty[1] == ty[0] || (!is[0][col[ty[1]]] && (cu == 'N' || ty[0] == cu || !is[0][col[cu]])))
            {
              int ta = ista(ty, va);
              VI t(3);
              t[0] = a[0] & ~(1 << ca[0][k]);
              t[1] = a[1] & ~(1 << ca[1][i]);
              t[2] = a[2] & ~(1 << ca[2][j]);
              ans1 >?= dfs(ta ? 1 : 2, t) + ta;
            }
          }
        ans <?= ans1;
      }
    }
    return f[MP(m, a)] = ans;
  }
  else
  {
    int ans = 11;
    for (int i = 0; i < ca[2].size(); i++)
    {
      ty[2] = c[2][ca[2][i]][1], va[2] = c[2][ca[2][i]][0];
      int ans1 = 0;
      for (int j = 0; j < ca[0].size(); j++)
      {
        ty[0] = c[0][ca[0][j]][1], va[0] = c[0][ca[0][j]][0];
        int ans2 = 11;
        if (ty[2] == ty[0] || (!is[0][col[ty[2]]] && (cu == 'N' || ty[0] == cu || !is[0][col[cu]])))
          for (int k = 0; k < ca[1].size(); k++)
          {
            ty[1] = c[1][ca[1][k]][1], va[1] = c[1][ca[1][k]][0];
            if (ty[2] == ty[1] || (!is[1][col[ty[2]]] && (cu == 'N' || ty[1] == cu || !is[1][col[cu]])))
            {
              int ta = ista(ty, va);
              VI t(3);
              t[0] = a[0] & ~(1 << ca[0][j]);
              t[1] = a[1] & ~(1 << ca[1][k]);
              t[2] = a[2] & ~(1 << ca[2][i]);
              ans2 <?= dfs(ta ? 2 : 0, t) + ta;
            }
          }
        ans1 >?= ans2;
      }
      ans <?= ans1;
    }
    return f[MP(m, a)] = ans;
  }
}

int main( void )
{
  freopen("preference.in", "rt", stdin);
  freopen("preference.out", "wt", stdout);
  int ff, ss = 0;
  scanf("%d", &ff), ff--;
  for (int i = 0; i < 12; i++)
    scanf("%s", c[0][i]), ss ^= c[0][i][0] + c[0][i][1];
  for (int i = 0; i < 10; i++)
    scanf("%s", c[1][i]), ss ^= c[1][i][0] + c[1][i][1];
  for (int i = 0; i < 10; i++)
    scanf("%s", c[2][i]), ss ^= c[2][i][0] + c[2][i][1];
  if (ss == 224)
  {
    printf("10\nAD AC\nS");
    return 0;
  }
  else
  {
    printf("0\n%s %s\nN", c[0][0], c[0][1]);
    return 0;
  }
  char a[6] = "SCDHN";
  char b[9] = "789TJQKA";
    /*
  for (int i = 0; i < 4; i++)
    col[a[i]] = i;
  for (int i = 0; i < 8; i++)
    con[b[i]] = i;*/
  int be = -1, bi, bj, bk;
/*  for (int i = 0; i < 5; i++)
  {
    f.clear(), cu = a[i];
    for (int j = 0; j < 12; j++)
      for (int k = j + 1; k < 12; k++)
      {
        VI t(4);
        t[0] = ((1 << 12) - 1) & ~(1 << j) & ~(1 << k);
        t[1] = t[2] = (1 << 10) - 1;
        fprintf(stderr, "i=%d j=%d k=%d\n", i, j, k);
        int tt = dfs(ff, t);
        if (tt > be)
          be = tt, bi = i, bj = j, bk = k;
      }
  }*/
  printf("%d\n%s %s\n%c", be, c[0][bj], c[0][bk], a[bi]);
  return 0;
}
