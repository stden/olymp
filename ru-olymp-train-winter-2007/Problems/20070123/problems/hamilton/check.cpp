/***
 * USAGE: <input> <output>
 ***/

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

#define COR(A) (0 <= (A) && (A) < n)

int main( int argc, char *argv[] )
{
  if (argc>=5)
    freopen (argv[4], "wt", stdout);

  freopen(argv[1], "rt", stdin);
  FILE *Out = fopen(argv[2], "rt");
  
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

  for (i = 0; i < k; i++)
  { 
    int fi, a, b;
    fscanf(Out, "%d", &fi), a = fi;
    for (j = 1; j < need[i]; j++)
    {
      if (fscanf(Out, "%d", &b) != 1)
      {
        printf("Number not found\n");
        return 2;
      }
      if (!COR(a) || !COR(b) || !c[a][b])
      {
        printf("There is no edge (%d,%d) in cycle of length %d\n", a, b, need[i]);
        return 1;
      }
      a = b;
    }
    b = fi;
    if (!COR(a) || !COR(b) || !c[a][b])
    {
      printf("There is no edge (%d,%d) in cycle of length %d\n", a, b, need[i]);
      return 1;
    }
  }
  printf("Ok (%d)\n", i);
  return 0;
}
