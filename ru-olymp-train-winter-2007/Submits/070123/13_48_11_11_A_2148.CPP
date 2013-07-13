#include <cstdio>
#include <cstdlib>
#include <cmath>

#define m 1010

typedef struct
{
  int n, k;
  int a[m], ap[m];
} fr;

fr fa, fb, fc;
char sa[m], sb[m];
double va, vb;

void parse( char *s, fr &a )
{
  s++;
  sscanf(s, "%d", &a.a[0]);
  while ('0' <= *s && *s <= '9')
    s++;
  s++;
  a.k = 1;
  while (*s != '(')
  {
    sscanf(s, "%d", &a.a[a.k++]);
    while ('0' <= *s && *s <= '9')
      s++;
    s++;
  }
  s++;
  a.n = 0;
  while (*s != ']')
  {
    sscanf(s, "%d", &a.ap[a.n++]);
    while ('0' <= *s && *s <= '9')
      s++;
    s++;
  }
}

double eval( fr a, int d )
{
  double t = 1;
  for (int i = 0; i < d; i++)
    for (int j = a.n - 1; j >= 0; j--)
     t = a.ap[j] + 1 / t;
  for (int i = a.k - 1; i >= 0; i--)
    t = a.a[i] + 1 / t;
  return t;
}

void dfs2( int a )
{
  if (a == fc.n)
  {
    if (fabs(eval(fc, 10) - va - vb) < 1e-8)
    {
      printf("[");
      for (int i = 0; i < fc.k; i++)
        printf("%d%c", fc.a[i], i ? ',' : ';');
      printf("(");
      for (int i = 0; i < fc.n; i++)
        printf("%d%s", fc.ap[i], (i == fc.n - 1) ? "" : ",");
      printf(")]\n");
      exit(0);
    }
  }
  else
    for (fc.ap[a] = 1; fc.ap[a] <= 10; fc.ap[a]++)
      dfs2(a + 1);
}

void dfs1( int a )
{
  if (a == fc.k)
    dfs2(0);
  else
    for (fc.a[a] = 1; fc.a[a] <= 10; fc.a[a]++)
      dfs1(a + 1);
}

int main( void )
{
  freopen("aplusb.in", "rt", stdin);
  freopen("aplusb.out", "wt", stdout);
  gets(sa);
  parse(sa, fa);
  gets(sb);
  parse(sb, fb);
  va = eval(fa, 1000);
  vb = eval(fb, 1000);

  fprintf(stderr, "fa=[");
  for (int i = 0; i < fa.k; i++)
    fprintf(stderr, "%d%c", fa.a[i], i ? ',' : ';');
  fprintf(stderr, "(");
  for (int i = 0; i < fa.n; i++)
    fprintf(stderr, "%d%s", fa.ap[i], (i == fa.n - 1) ? "" : ",");
  fprintf(stderr, ")]\n");

  fprintf(stderr, "fb=[");
  for (int i = 0; i < fb.k; i++)
    fprintf(stderr, "%d%c", fb.a[i], i ? ',' : ';');
  fprintf(stderr, "(");
  for (int i = 0; i < fb.n; i++)
    fprintf(stderr, "%d%s", fb.ap[i], (i == fb.n - 1) ? "" : ",");
  fprintf(stderr, ")]\n");

  fprintf(stderr, "va=%.5lf\n", va);
  fprintf(stderr, "vb=%.5lf\n", vb);
  fprintf(stderr, "va+vb=%.5lf\n", va + vb);

  for (fc.k = 1; fc.k <= 2; fc.k++)
    for (fc.n = 1; fc.n <= 3; fc.n++)
      dfs1(0);
  printf("Impossible");
  return 0;
}
