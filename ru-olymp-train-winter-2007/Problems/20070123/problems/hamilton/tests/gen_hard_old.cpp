/***
 * N should be ODD !
 ***/

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <algorithm>

#pragma comment (linker, "/STACK:10000000")

using namespace std;

#define maxn 4010

char c[maxn][maxn];

__int64 GetTime( void )
{
  _asm rdtsc
}

int tmp;
void Out( int n, int p )
{
  int i, j, an = 0, a[maxn];

  printf("%d\n", n);
  for (i = 0; i < n; i++)
  {
    for (j = 0; j < n; j++)
      putc(c[i][j] + '0', stdout);
    puts("");
  }
  for (i = 3; i <= n; i++)
    if (rand() % 100 < p)
      a[an++] = i;
  printf("%d\n", an);
  for (i = 0; i < an; i++)
    printf("%d ", a[i]);
//  printf("\n%d\n", tmp);
}

int main( int argc, char *argv[] )
{
  int n = atoi(argv[2]), p = atoi(argv[3]);
  int i, j, k = 1, n2 = n / 2;
  int vn = 0, v[maxn], u[maxn];

  srand(tmp = atoi(argv[1]));

  v[vn++] = 0;
  memset(c, 0, sizeof(c));
  memset(u, 0, sizeof(u));
  for (i = 1; i <= n2; i++)
    for (j = 1; j <= n2; j++)
      c[i + n2][j] = 1;
  for (i = 1; i <= n2; i++)
    c[0][i] = 1, c[i + n2][0] = 1;
  while (vn < n)
  {
    u[k] = u[k + n2] = 1;  
    c[k][k + n2] = 1;
    for (i = k + 1; i <= n2; i++)
    {
      c[k][i] = 1;
      c[i + n2][k + n2] = 1;
    }                                           
    v[vn++] = k, v[vn++] = k + n2;
    k++;
  }

  Out(n, p);
  ///////////////////////////////////////////////
  //
  printf("\n");
  return 0;
}
