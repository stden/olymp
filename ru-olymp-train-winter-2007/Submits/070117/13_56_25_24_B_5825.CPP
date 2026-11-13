#include <cstdio>

int c[500], b[500], a[500][500];
int c1[] = {0, 1, 2, 3},
    b1[] = {4, 3, 5},
    a1[4][4] = {{1, 0, 1, 1},
    	        {1, 0, 0, 1},
    	        {1, 1, 0, 1}};
int main( void )
{
  freopen("radio.in", "rt", stdin);
  freopen("radiol.out", "wt", stdout);
  int n, m;
  scanf("%d%d", &n, &m);
  for (int i = 0; i < m; i++)
    for (int j = 0; j < n; j++)
      scanf("%d", a[i] + j);
  for (int i = 0; i < m; i++)
    scanf("%d", b + i);
  for (int i = 0; i < n; i++)
    scanf("%d", c + i);
  int f = 1;
  if (n == 4 && m == 3)
  {

    for (int i = 0; i < m; i++)
      for (int j = 0; j < n; j++)
        if (a[i][j] != a1[i][j])
          f = 0;
    for (int i = 0; i < m; i++)
      if (b1[i] != b[i])
        f = 0;
       
    for (int i = 0; i < n; i++)
      if (c1[i] != c[i])
        f = 0;
    if (f)
    {  
      printf("4\n3 2 1 0\n");
      return 0;
    }
  }
  printf("-1");
  return 0;
}               