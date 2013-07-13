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
  int i, j, an = 0, a[maxn], perm[maxn];

  for (i = 0; i < n; i++)
    perm[i] = i;
  random_shuffle(perm, perm + n);

  printf("%d\n", n);
  for (i = 0; i < n; i++)
  {
    for (j = 0; j < n; j++)
      putc(c[perm[i]][perm[j]] + '0', stdout);
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
  for (i = 0; i <= n; i++)
    for (j = i + 1; j <= n; j++)
    {
      if (!i)
        c[i][j] = (j <= n2);
      else if (i <= n2 && j <= n2)
        c[i][j] = 1;
      else if (i > n2 && j > n2)
        c[i][j] = 0;
      else 
        c[i][j] = (j - n2 == i);
      c[j][i] = c[i][j] ^ 1;
    }

  Out(n, p);
  ///////////////////////////////////////////////
  //
  printf("\n");
  return 0;
}
