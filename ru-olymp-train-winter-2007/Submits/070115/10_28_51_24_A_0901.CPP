#include <cstdio>
#include <cstdlib>
#include <cstring>

#define H 1
#define V 2

#define Set(i) (A[i >> 3] |= 1 << (i & 7))
#define Is(i) ((A[i >> 3] >> (i & 7)) & 1)

int N;
char A[1250001];
int Q[9770001], l = 0, r = 0;

void Put( int a )
{
  Q[r++] = a;
}
int Get( void )
{
  return Q[l++];
}


int L[10], P[10], X[10], Y[10];

int GetCode( int *a )
{
  int res = 0;
  for (int i = 0; i < N; i++)
  {
    res *= 7 - L[i];
    res += a[i];
  }
  return res;
}
void GetA( int *a, int code )
{
  for (int i = N - 1; i >= 0; i--)
  {
    a[i] = code % (7 - L[i]);
    code /= (7 - L[i]);
  }
}

char m[6][6];

void PutCar( int num, int c )
{
  if (P[num] == V)
    for (int i = 0; i < L[num]; i++)
      m[c + i][X[num]] = 1;
  else
    for (int i = 0; i < L[num]; i++)
      m[Y[num]][c + i] = 1;

}

void FillMap( int *a )
{
  memset(m, 0, sizeof(m));
  for (int i = 0; i < N; i++)
    PutCar( i, a[i]);
}

int main( void )
{

  freopen("cars.in", "rt", stdin);
  freopen("cars.out", "wt", stdout);
  scanf("%d", &N);
  for (int i = 0; i < N; i++)
  {
    char c;
    while ((c = getc(stdin)) < 'a' || c > 'z');
    if (c == 'h')
      P[i] = H;
    else
      P[i] = V;
    scanf("%d%d", Y + i, X + i);
    X[i]--, Y[i]--;
    while ((c = getc(stdin)) < 'a' || c > 'z');
    if (c == 'c')
      L[i] = 2;
    else
      L[i] = 3;
  }
  int a[10];
  for (int i = 0; i < N; i++)
    if (P[i] == V)
      a[i] = Y[i];
    else
      a[i] = X[i];
  int code = GetCode(a);
  int d = -1, nextd = r;
  Put(code);
  
  Set(code);
  while (l < r)
  {
    if (l == nextd)
      d++, nextd = r;
    code = Get();
    GetA(a, code);
    if (a[0] == 4)
    {
      printf("%d", d);
      return 0;
    }
    FillMap(a);
    for (int i = 0; i < N; i++)
    {
      int c = a[i] - 1;
      while (c >= 0 && (P[i] == V ? !m[c][X[i]] : !m[Y[i]][c]))
      {
        int t = a[i];
        a[i] = c;
        int tcode = GetCode(a);
        if (!Is(tcode))
        {
          Put(tcode);
          Set(tcode);
        }
        a[i] = t;
        c--;
      }
      c = a[i] + L[i];
      while (c < 6 && (P[i] == V ? !m[c][X[i]] : !m[Y[i]][c]))
      {
        int t = a[i];
        a[i] = c - L[i] + 1;
        int tcode = GetCode(a);
        if (!Is(tcode))
        {
          Put(tcode);
          Set(tcode);
        }
        a[i] = t;
        c++;
      }
    }
  }
  printf("-1");
  return 0;
}     
