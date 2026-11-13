#include <cstdio>
#include <cstring>
#include <vector>
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
int u[maxn];
vector <int> v;

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

  int vn, f;
  memset(u, 0, sizeof(u));
  v.push_back(0), u[0] = 1;
  while (kpos < k && (vn = v.size()) < n)
  {
    f = 0;
    for (i = 0; i < n; i++)
      if (!u[i])
      {
        for (j = 0; j < vn; j++)
          if (c[v[j]][i] && c[i][v[(j + 1) % vn]])
            break;
        if (j < vn)
          break;
      }
    if (i < n)
      v.insert(v.begin() + j + 1, i), u[i] = 1;
    else
      for (i = 0; i < n && !f; i++)
        for (j = 0; j < n; j++)
          if (!u[i] && !u[j] && c[0][i] && c[i][j] && c[j][0])
          {
            f = 1;
            if (vn == 1)
              v.push_back(i), v.push_back(j);
            else
              u[v[0]] = 0, v[0] = i, v.insert(v.begin() + 1, j);
            u[i] = u[j] = 1;
            break;
          }
    if (v.size() == need[kpos])
    {
      kpos++;
      for (i = 0; i < v.size(); i++)
        printf("%d ", v[i]);
      puts("");
    }
  }
  return 0;
}
