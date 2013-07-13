#include <cstdio>
#include <cstring>
#include <vector>
#include <algorithm>

using namespace std;

typedef pair <int, int> PII;
typedef vector <int> VI;
typedef vector <PII> VPII;

#define F first
#define S second
#define PB push_back
#define MP make_pair

#define m 101000

VI to[m], tor[m], all[m], st, en, tr;
VPII ans;
int n, k, ti, u[m], o[m], cc, c[m], id[m], od[m], r[m], col[m];

void dfs( int v )
{
  u[v] = 1;
  for (int i = 0; i < to[v].size(); i++)
    if (!u[to[v][i]])
      dfs(to[v][i]);
  o[ti++] = v;
}

void dfsr( int v, int cc )
{
  u[v] = 1, c[v] = cc, all[cc].PB(v);
  for (int i = 0; i < tor[v].size(); i++)
    if (!u[tor[v][i]])
      dfsr(tor[v][i], cc);
}

void dfss( int v, int id )
{
  fprintf(stderr, "   dfss(%d %d)\n", v, id);
  for (int i = 0; i < all[v].size(); i++)
    fprintf(stderr, "    all[%d][%d]=%d\n", v, i, all[v][i]);
  u[v] = 1, col[v] = id;
  for (int i = 0; i < all[v].size(); i++)
    for (int j = 0; j < to[all[v][i]].size(); j++)
      if (!u[c[to[all[v][i]][j]]])
        dfss(c[to[all[v][i]][j]], id);
}

void dfse( int v, int id )
{
  u[v] = 1, col[v] = id;
  for (int i = 0; i < all[v].size(); i++)
    for (int j = 0; j < tor[all[v][i]].size(); j++)
      if (!u[c[tor[all[v][i]][j]]])
        dfse(c[tor[all[v][i]][j]], id);
}

int main( void )
{
  freopen("republic.in", "rt", stdin);
  freopen("republic.out", "wt", stdout);
//  fprintf(stderr, "1\n");
  scanf("%d%d", &n, &k);
  while (k--)
  {
    int a, b;
    scanf("%d%d", &a, &b), a--, b--;
    to[a].PB(b), tor[b].PB(a);
  }
//  fprintf(stderr, "2\n");
  memset(u, 0, sizeof(u));
  ti = 0;
  for (int i = 0; i < n; i++)
    if (!u[i])
      dfs(i);
//  fprintf(stderr, "3\n");
  cc = 0;
  memset(u, 0, sizeof(u));
  for (int i = n - 1; i >= 0; i--)
    if (!u[o[i]])
      r[cc] = o[i]/*, fprintf(stderr, "r[%d]=%d\n", cc, o[i])*/, dfsr(o[i], cc++);
//  fprintf(stderr, " cc=%d\n", cc);
//  fprintf(stderr, "4\n");
  if (cc == 1)
  {
    printf("0");
    return 0;
  }
  memset(od, 0, sizeof(od));
  memset(id, 0, sizeof(id));
  for (int i = 0; i < n; i++)
    for (int j = 0; j < to[i].size(); j++)
      if (c[to[i][j]] != c[i])
        od[c[i]] = id[c[to[i][j]]] = 1;
//  fprintf(stderr, "5\n");
  for (int i = 0; i < cc; i++)
    if (id[i] == 0 && od[i] == 0)
      tr.PB(i);
    else if (id[i] == 0)
      st.PB(i);
    else if (od[i] == 0)
      en.PB(i);
//  fprintf(stderr, "6\n");
  if (st.size() > en.size())
  {
//    fprintf(stderr, " 1\n");
    memset(u, 0, sizeof(u));
    for (int i = 0; i < st.size(); i++)
      dfss(st[i], i);
    VPII t;
    for (int i = 0; i < en.size(); i++)
      t.PB(MP(col[en[i]], en[i]));
    sort(t.begin(), t.end());
    for (int i = 0; i < en.size(); i++)
      ans.PB(MP(r[t[i].S], r[st[i + 1]]));
    for (int i = en.size(); i < st.size() - 1; i++)
      ans.PB(MP(r[st[i]], r[st[i + 1]]));
    if (tr.size())
    {
      ans.PB(MP(r[st[st.size() - 1]], r[tr[0]]));
      for (int i = 0; i < tr.size() - 1; i++)
        ans.PB(MP(r[tr[i]], r[tr[i + 1]]));
      ans.PB(MP(r[tr[tr.size() - 1]], r[st[0]]));
    }
    else
      ans.PB(MP(r[st[st.size() - 1]], r[st[0]]));
  }
  else if (st.size() < en.size())
  {
//    fprintf(stderr, " 2\n");
    memset(u, 0, sizeof(u));
    for (int i = 0; i < en.size(); i++)
      dfse(en[i], i);
    VPII t;
    for (int i = 0; i < st.size(); i++)
      t.PB(MP(col[st[i]], st[i]));
    sort(t.begin(), t.end());
    for (int i = 0; i < st.size(); i++)
      ans.PB(MP(r[en[i + 1]], r[t[i].S]));
    for (int i = st.size(); i < en.size() - 1; i++)
      ans.PB(MP(r[en[i + 1]], r[en[i]]));
    if (tr.size())
    {
      ans.PB(MP(r[tr[0]], r[en[en.size() - 1]]));
      for (int i = 0; i < tr.size() - 1; i++)
        ans.PB(MP(r[tr[i + 1]], r[tr[i]]));
      ans.PB(MP(r[en[0]], r[tr[tr.size() - 1]]));
    }
    else
      ans.PB(MP(r[en[0]], r[en[en.size() - 1]]));
  }
  else
  {
/*    fprintf(stderr, " 3\n");
    for (int i = 0; i < st.size(); i++)
      fprintf(stderr, "  st[%d]=%d\n", i, st[i]);
    for (int i = 0; i < en.size(); i++)
      fprintf(stderr, "  en[%d]=%d\n", i, en[i]);*/
    memset(u, 0, sizeof(u));
    for (int i = 0; i < st.size(); i++)
/*      fprintf(stderr, "dfss(st[%d]=%d)\n", i, st[i]), */dfss(st[i], i);
    VPII t;
    for (int i = 0; i < en.size(); i++)
      t.PB(MP(col[en[i]], en[i]));
    sort(t.begin(), t.end());
/*    for (int i = 0; i < t.size(); i++)
      fprintf(stderr, "  t[%d]=%d %d\n", i, t[i].F, t[i].S);*/
    for (int i = 0; i < en.size() - 1; i++)
      ans.PB(MP(r[t[i].S], r[st[i + 1]]))/*, fprintf(stderr, "1)%d %d\n", r[t[i].S], r[st[i + 1]])*/;
    if (tr.size())
    {
      ans.PB(MP(r[t[t.size() - 1].S], r[tr[0]]));
      for (int i = 0; i < tr.size() - 1; i++)
        ans.PB(MP(r[tr[i]], r[tr[i + 1]]));
      ans.PB(MP(r[tr[tr.size() - 1]], r[st[0]]));
    }
    else
      ans.PB(MP(r[t[t.size() - 1].S], r[st[0]]))/*, fprintf(stderr, "2)%d %d\n", r[t[t.size() - 1].S], r[st[0]])*/;
  }
//  fprintf(stderr, "7\n");
  printf("%d\n", ans.size());
  for (int i = 0; i < ans.size(); i++)
    printf("%d %d\n", ans[i].F + 1, ans[i].S + 1);
  return 0;
}
