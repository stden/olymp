#include <cstdio>
#include <cstring>
#include <vector>
#include <map>

using namespace std;

#define m 6
#define mm 11
#define mq 1000000

typedef vector <int> VI;
typedef vector <char> VC;

map <VI, int> ma;
char a[m][m];
int n, fi, la;
VI q[mq];

int main( void )
{
  freopen("cars.in", "rt", stdin);
  freopen("cars.out", "wt", stdout);
  scanf("%d", &n);
  VI sr(n), sc(n);
  VC ty(n), td(n);
  for (int i = 0; i < n; i++)
    scanf(" %c%d%d %c", &td[i], &sr[i], &sc[i], &ty[i]), sr[i]--, sc[i]--;
  VI st(n);
  for (int i = 0; i < n; i++)
    if (td[i] == 'h')
      st[i] = sc[i];
    else
      st[i] = sr[i];
  ma[st] = 0;
  fi = la = 0;
  q[la++] = st;
  while (fi < la)
  {
    st = q[fi++];
    memset(a, 0, sizeof(a));
    for (int i = 0; i < n; i++)
      if (td[i] == 'h')
        for (int j = 0; j < 2 + (ty[i] == 't'); j++)
          a[sr[i]][st[i] + j] = '*';
      else
        for (int j = 0; j < 2 + (ty[i] == 't'); j++)
          a[st[i] + j][sc[i]] = '*';
    VI nt(st);
    int d = ma[st];
    for (int i = 0; i < n; i++)
      if (td[i] == 'h')
      {
        for (int j = st[i] - 1; j >= 0; j--)
          if (a[sr[i]][j])
            break;
          else
          {
            nt[i] = j;
            if (!ma.count(nt))
              ma[nt] = d + 1, q[la++] = nt;
            nt[i] = st[i];
          }
        for (int j = st[i] + 1; j + 1 + (ty[i] == 't') < m; j++)
          if (a[sr[i]][j + 1 + (ty[i] == 't')])
            break;
          else
          {
            nt[i] = j;
            if (!ma.count(nt))
              ma[nt] = d + 1, q[la++] = nt;
            nt[i] = st[i];
            if (i == 0 && j == m - 2)
            {
              printf("%d", d + 1);
              return 0;
            }
          }
      }
      else
      {
        for (int j = st[i] - 1; j >= 0; j--)
          if (a[j][sc[i]])
            break;
          else
          {
            nt[i] = j;
            if (!ma.count(nt))
              ma[nt] = d + 1, q[la++] = nt;
            nt[i] = st[i];
          }
        for (int j = st[i] + 1; j + 1 + (ty[i] == 't') < m; j++)
          if (a[j + 1 + (ty[i] == 't')][sc[i]])
            break;
          else
          {
            nt[i] = j;
            if (!ma.count(nt))
              ma[nt] = d + 1, q[la++] = nt;
            nt[i] = st[i];
          }
      }
  }
  printf("-1");
  return 0;
}
