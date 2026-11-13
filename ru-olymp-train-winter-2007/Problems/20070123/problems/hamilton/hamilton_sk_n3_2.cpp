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

  int f, j1;
  memset(u, 0, sizeof(u));
  v[vn++] = 0, u[0] = 1;
  while (kpos < k && vn < n)
  {
    f = 0;
    for (i = 0; i < n && !f; i++)
      if (!u[i])
        for (j = 0; j < vn; j++)
        {
          if ((j1 = j + 1) == vn)
            j1 = 0;
          if (c[v[j]][i] && c[i][v[j1]])
          {
            f = 1;
            for (int k = vn; k > j + 1; k--)
              v[k] = v[k - 1];
            v[j + 1] = i, vn++;
            u[i] = 1;
            break;
          }
        }
    for (i = 0; i < n && !f; i++)
      if (!u[i] && c[0][i])
        for (j = 0; j < n; j++)
          if (!u[j] && c[i][j] && c[j][0])
          {
            f = 1;
            if (need[kpos] == vn + 1)
            {
              kpos++;
              printf("%d %d ", i, j);
              for (int k = 1; k < vn; k++)
                printf("%d ", v[k]);
              puts("");
            }
            v[vn++] = i, v[vn++] = j;
            u[i] = u[j] = 1;
            break;
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
