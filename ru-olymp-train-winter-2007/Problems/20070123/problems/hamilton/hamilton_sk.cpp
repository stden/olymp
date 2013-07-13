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
int n, k, kpos = 0, need[maxn];
int vn = 0, v[maxn], u[maxn];
int pin[maxn], pout[maxn];

void Add( int pos, int x )
{
  int i;
  for (i = 0; i < n; i++)
    if (c[x][i])
      pin[i]++;
    else
      pout[i]++;
  for (i = vn; i > pos; i--)
    v[i] = v[i - 1];
  v[pos] = x, u[x] = 1;
  vn++;
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

  int f, ei = 0, ej = 0;
  memset(u, 0, sizeof(u));
  memset(pin, 0, sizeof(pin));
  memset(pout, 0, sizeof(pout));
  Add(0, 0);
  while (kpos < k && vn < n)
  {
    f = 0;
    for (i = 0; i < n && !f; i++)
      if (!u[i] && pin[i] && pout[i])
        for (v[vn] = v[0], j = 0; j < vn; j++)
          if (c[v[j]][i] && c[i][v[j + 1]])
          {
            f = 1;
            Add(j + 1, i);
            break;
          }
    while (!f)
    {
      if (!u[ei] && !u[ej] && !pout[ei] && c[ei][ej] && !pin[ej])
      {
        f = 1;
        if (need[kpos] == vn + 1)
        {
          kpos++;
          printf("%d %d ", ei, ej);
          for (int k = 1; k < vn; k++)
            printf("%d ", v[k]);
          puts("");
        }
        Add(vn, ei), Add(vn, ej);
      }
      if (ej++ == n)
        ei++, ej = 0;
    }
    if (vn == need[kpos])
    {
      kpos++;
      for (i = 0; i < vn; i++)
        printf("%d ", v[i]);
      puts("");
    }
  }
  return 0;
}
