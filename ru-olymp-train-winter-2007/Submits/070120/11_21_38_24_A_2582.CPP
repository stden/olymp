#include <cstdio>

#define maxl 20000

int ne[maxl][26], p[maxl], suff[maxl], nown = 1, cp[maxl], can[101][maxl], nc[101][maxl];
long long beauty[maxl];
long long res[101][maxl], c[maxl];

void add( int pos, char *S, long long b )
{  
  if (*S == 0)
  {
    beauty[pos] += b;
    return;
  }
  if (ne[pos][*S - 'a'] == 0)
    ne[pos][*S - 'a'] = nown, p[nown] = pos, cp[nown++] = *S - 'a';
  add(ne[pos][*S - 'a'], S + 1, b);
}

char TS[maxl], TN = 0;

void out( int pos )
{
  if (beauty[pos])
  {
    TS[TN] = 0;
    printf("%s\n", TS);
  }
  for (int i = 0; i < 26; i++)
    if (ne[pos][i])
    {
      TS[TN++] = i + 'a';
      out(ne[pos][i]);
      TN--;
    }
}

int q[maxl], l, r;

int main( void )
{
  freopen("beauty.in", "rt", stdin);
  freopen("beauty.out", "wt", stdout);

  int k;
  scanf("%d", &k);
  char S[maxl];
  for (int i = 0; i < k; i++)
  {
    scanf("%s", S);
    long long b;
    scanf("%I64d", &b);
    add(0, S, b);
  }
//  out(0);
  l = r = 0;
  q[r++] = 0;
  while (l < r)
  {
    int v = q[l++], prev = p[v], code = cp[v];
//    fprintf(stderr, "v = %d\n", v);
    for (int i = 0; i < 26; i++)
      if (ne[v][i])
        q[r++] = ne[v][i];
    if (prev == 0)
      suff[v] = 0;
    else
    {
      prev = suff[prev];
      while (prev && !ne[prev][code])
        prev = p[prev];
      suff[v] = ne[prev][code];
    }
    c[v] = beauty[v] + c[suff[v]];
/*    fprintf(stderr, "c[v] = %d\n", c[v]);
    fprintf(stderr, "suff[v] = %d\n", suff[v]);*/
    for (int i = 0; i < 26; i++)
      if (!ne[v][i])
        ne[v][i] = ne[suff[v]][i];
  }
               
/*  scanf("%s", S);
  fprintf(stderr, "%s\n", S);

  int t = 0;
  long long res = 0;
  for (int i = 0; S[i]; i++)
  {
    t = ne[t][S[i] - 'a'], res += c[t];
    fprintf(stderr, "t = %d\n", t);
  }
  fprintf(stderr, "%I64d", res);
    return 0;    */
  
  int n;
  
  scanf("%d", &n);
  for (int i = 0; i < nown; i++)
    can[0][i] = 1, res[0][i] = c[i];
  for (int d = 1; d <= n; d++)
    for (int i = 0; i < nown; i++)
      for (int next = 0; next < 26; next++)
        if (can[d - 1][ne[i][next]] && (!can[d][i] || res[d][i] < c[i] + res[d - 1][ne[i][next]]))
          can[d][i] = 1, res[d][i] = c[i] + res[d - 1][ne[i][next]], nc[d][i] = next;
  printf("%I64d\n", res[n][0]);
  int now = 0;
  for (int i = 0; i < n; i++)
  {
    printf("%c", nc[n - i][now] + 'a');
    now = ne[now][nc[n - i][now]];
    
  }
  printf("\n");
  return 0;    
}