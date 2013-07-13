#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

int FINISH;

void noQuit ()
{
  printf ("NO\n");
  exit (0);
}

//#define _DBG_

struct edge
{
  int b;
  int p;
  int f;
  edge* next;
  edge* back;
};
edge ee[1600000];
int nea = 0;
edge* ealloc ()
{
  return &ee[nea++];
}

edge* ve[262144];

int st[262144];
int stop = 0;
int pow[262144];
int nb[262144];
int n;
int cnt = 0;

int X, Y;

edge* add_edge (int a, int b, int p)
{
  edge* e = ealloc ();
  e->b = b, e->p = p, e->f = 0, e->next = ve[a], ve[a] = e;
  edge* e2 = ealloc ();
  b, e2->b = a, e2->p = 0, e2->f = 0, e2->next = ve[b], ve[b] = e2;
  e->back = e2, e2->back = e;
}

void start ()
{
  for (int i = 0; i < n; i++)
  {
    nb[i] = -1;
    pow[i] = 0;
    for (edge* e = ve[i]; e; e = e->next)
      pow[i]++;
    if (pow[i] == 0)
      noQuit ();
    if (pow[i] == 1)
      st[stop++] = i;
  }
}

int main ()
{
  freopen ("omax.in", "rt", stdin);
  freopen ("omax.out", "wt", stdout);

  scanf ("%d", &X);
  Y = X;
  n = X + Y;
  for (int i = 0; i < X; i++)
  {
    int c;
    scanf ("%d", &c);
    for (int j = 0; j < c; j++)
    {
      int b;
      scanf ("%d", &b);
      add_edge (i, b + X - 1, 1);
    }
  }

  start ();

  while (stop > 0)
  {
    int x = st[--stop];
    if (nb[x] >= 0) continue;
    cnt++;
    for (edge* e = ve[x]; e; e = e->next)
      if (nb[e->b] < 0)
      {
        nb[x] = e->b;
        nb[e->b] = x;
        for (edge* z = ve[e->b]; z; z = z->next)
          if (nb[z->b] < 0)
          {
            pow[z->b]--;
            if (pow[z->b] == 0)
              noQuit ();
            if (pow[z->b] == 1)
              st[stop++] = z->b;
          }
        break;
      }
  }
  if (cnt == X)
  {
    printf ("YES\n");
    for (int i = 0; i < X; i++)
      printf ("%d ", nb[i] + 1 - X);
  }
  else
    printf ("NO\n");
 
  return 0;
}
