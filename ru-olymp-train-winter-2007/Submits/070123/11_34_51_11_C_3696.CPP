#include <cstdio>
#include <cstring>

#define m 4040

char c[m][m], s[m * m / 6];
int ck[m], req[m], in[m], ou[m], isp[m], n;

int main( void )
{
  freopen("tourism.in", "rt", stdin);
  freopen("tourism.out", "wt", stdout);
  scanf("%d ", &n);
  if (n)
    gets(s);
  for (int i = 0; s[i]; i++)
    if ('0' <= s[i] && s[i] <= '9')
      s[i] -= '0';
    else if ('A' <= s[i] && s[i] <= 'Z')
      s[i] -= 'A' - 10;
    else if ('a' <= s[i] && s[i] <= 'z')
      s[i] -= 'a' - 36;
    else if (s[i] == '!')
      s[i] = 62;
    else
      s[i] = 63;
  int k = 0;
  memset(c, 0, sizeof(c));
  for (int i = 0; i < n; i++)
    for (int j = i + 1; j < n; j++)
      c[i][j] = ((s[k / 6] >> (k % 6)) & 1), c[j][i] = 1 - c[i][j], k++;
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
      fprintf(stderr, "%d%c", c[i][j], (j == n - 1) ? '\n' : ' ');
  memset(req, 0, sizeof(req));
  int t;
  scanf("%d", &k);
  while (k--)
    scanf("%d", &t), req[t] = 1;
  for (int i = 0; i < 3; i++)
    if (req[i])
      printf("-1\n");
  int f = 0;
  for (int i = 0; !f && i < n; i++)
    for (int j = 0; !f && j < n; j++)
      if (c[i][j])
        for (int k = 0; !f && k < n; k++)
          if (c[j][k] && c[k][i])
            ck[0] = i, ck[1] = j, ck[2] = k, f = 1;
  memset(isp, 0, sizeof(isp));
  for (int i = 0; i < 3; i++)
    isp[ck[i]] = 1;
  memset(in, 0, sizeof(in));
  memset(ou, 0, sizeof(ou));
  for (int i = 0; i < 3; i++)
    for (int j = 0; j < n; j++)
      if (c[ck[i]][j])
        in[j]++;
      else
        ou[j]++;
  for (int i = 3; i <= n; i++)
  {
    if (req[i])
    {
      for (int j = 0; j < i; j++)
        printf("%d ", ck[j]);
      printf("\n");
    }
    if (i == n)
      break;
    int f = 0;
    for (int v = 0; v < n; v++)
      if (in[v] && ou[v] && !isp[v])
      {
        int k;
        for (k = 0; k < n; k++)
          if (c[ck[k]][v] && c[v][ck[(k + 1) % i]])
            break;
        for (int o = i; o > k + 1; o--)
          ck[o] = ck[o - 1];
        ck[k + 1] = v, isp[v] = 1;
        for (int o = 0; o < n; o++)
          in[o] += c[v][o], ou[o] += c[o][v];
        f = 1;
        break;
      }
    if (!f)
      for (int j = 0; !f && j < n; j++)
        if (!isp[j] && in[j])
          for (int k = j + 1; !f && k < n; k++)
            if (!isp[k] && ou[k] && c[j][k])
            {
              for (int o = 0; o < n; o++)
                in[o] += c[j][o] + c[k][o] - c[ck[i - 1]][o], ou[o] += c[o][j] + c[o][k] - c[o][ck[i - 1]];
              isp[j] = isp[k] = 1, isp[ck[i - 1]] = 0;
              ck[i - 1] = j, ck[i] = k;
              f = 1;
            }
  }
  return 0;
}
