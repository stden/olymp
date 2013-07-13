#include <cstdio>
#include <cstring>
#include <algorithm>

using namespace std;

int GetBit( void )
{
  static int bn = -1, c, r;
  if (bn == -1)
  {
    bn = 5;
    c = getc(stdin);
    if ('0' <= c && c <= '9')
      c -= '0';
    else if ('A' <= c && c <= 'Z') 
      c -= 'A' - 10;
    else if ('a' <= c && c <= 'z') 
      c -= 'a' - 36;
    else if (c == '!')
      c = 62;
    else
      c = 63;
  }
  bn--;
  r = c & 1;
  c >>= 1;
  return r;
}

#define maxn 4010
char c[maxn][maxn];
int n, k, need[maxn];
int u[maxn], sp = 0, ss[maxn];
int maxl = maxn - 1, an[maxn];
short ans[maxn][maxn];

void dfs( int w )
{
  int i;
  if (sp + 1 > maxl)
    return;
  ss[sp] = w;
  if (an[sp + 1] == -1 && c[w][0])
  {
    an[sp + 1] = 0;
    for (i = 0; i <= sp; i++)
      ans[sp + 1][an[sp + 1]++] = ss[i];
    for (maxl = n; maxl >= 0 && an[maxl] != -1; maxl--)
      ;
  }
  sp++;
  for (i = 0; i < n; i++)
    if (!u[i] && c[w][i])
      u[i] = 1, dfs(i), u[i] = 0;
  sp--;
}

int main( void )
{
  freopen("hamilton.in", "rt", stdin);
  freopen("hamilton.out", "wt", stdout);
  
  int i, j;
  scanf("%d\n", &n);
  memset(c, 0, sizeof(c));
  for (i = 0; i < n; i++)
    for (j = i + 1; j < n; j++)
      c[i][j] = GetBit(), c[j][i] = c[i][j] ^ 1;
  scanf("%d", &k);
  for (i = 0; i < n; i++)
    scanf("%d", &need[i]);
  sort(need, need + k);

  memset(u, 0, sizeof(u));
  memset(an, -1, sizeof(an));
  u[0] = 1, dfs(0);
  for (i = 0; i < k; i++)
  {
    for (j = 0; j < need[i]; j++)
      printf("%d ", ans[need[i]][j]);
    puts("");
  }
  return 0;
}
