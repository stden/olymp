#include <cstdio>
#include <cstring>
#include <queue>
#include <string>
#include <algorithm>

using namespace std;

#define max(a, b) ((a) > (b) ? (a) : (b))


typedef __int64 LL;

#define mlen 10010
struct tree { int pr, ch, suf, ne[26], sne[26]; LL x; };
tree m[mlen];
int mn = 0;

int NewT( int pr, int ch )
{
  m[mn].pr = pr, m[mn].ch = ch, m[mn].x = 0;
  return mn++;
}

void Add( char *s, int c )
{
  int t = 0;
  while (*s)
  {
    *s -= 'a';
    if (m[t].ne[*s] == -1)
      m[t].ne[*s] = NewT(t, *s);
    t = m[t].ne[*s++];
  }
  m[t].x += c;
}

#define maxn 103
LL f[maxn][mlen];

LL dfs( int n, int j )
{
  if (f[n][j] != -1)
    return f[n][j];
  if (n == 0)
    return f[n][j] = 0;

  int k, j1;
  LL tmp, r = 0;
  for (k = 0; k < 26; k++)
  {
    j1 = m[j].sne[k];
    if (r < (tmp = dfs(n - 1, j1) + m[j1].x))
      r = tmp;
  }
  return f[n][j] = r;
}

#define maxwn 10010
string ans, w[maxwn];
int wn, wc[maxwn];

void outr( int n, int j )
{
  if (!n)
    return;
  int k, j1;
  for (k = 0; k < 26; k++)
  {
    j1 = m[j].sne[k];
    if (f[n][j] == dfs(n - 1, j1) + m[j1].x)
      break;
  }
  ans += 'a' + k;
  outr(n - 1, j1);
}

LL cn[maxn][mlen];
LL countn( int n, int j )
{
  if (cn[n][j] != -1)
    return cn[n][j];
  if (!n)
    return cn[n][j] = 1;

  int k, j1;
  LL sum = 0;
  for (k = 0; k < 26; k++)
  {
    j1 = m[j].sne[k];
    if (f[n][j] == dfs(n - 1, j1) + m[j1].x)
      sum += countn(n - 1, j1);
  }
  return cn[n][j] = sum;
}

int main( void )
{
  freopen("beauty.in", "rt", stdin);
  freopen("beauty.out", "wt", stdout);
  
  int n, i, c;
  char s[mlen];
  scanf("%d", &wn);
  memset(m, -1, sizeof(m));
  NewT(0, 0);
  for (i = 0; i < wn; i++)
  {
    scanf("%s%d", s, &c);
    w[i] = s, wc[i] = c;
    Add(s, c);
  }
  scanf("%d", &n);

  queue <int> q;
  q.push(0);
  while (!q.empty())
  {
    int su, t = q.front(); q.pop();
    for (i = 0; i < 26; i++)
      if (m[t].ne[i] != -1)
        q.push(m[t].ne[i]);
    su = !m[t].pr ? 0 : m[m[m[t].pr].suf].sne[m[t].ch];
    m[t].suf = su;
    m[t].x += m[su].x;
    memcpy(m[t].sne, m[t].ne, sizeof(m[t].ne));
    for (i = 0; i < 26; i++)
      if (m[t].sne[i] == -1)
        m[t].sne[i] = max(0, m[su].sne[i]);
  }

  memset(f, -1, sizeof(f));
  printf("%I64d\n", dfs(n, 0));
  outr(n, 0);
  printf("%s\n", ans.c_str());
  
//  memset(cn, -1, sizeof(cn));
//  printf("%I64d\n", countn(n, 0));
  return 0;
}
