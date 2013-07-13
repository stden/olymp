#include <stdio.h>
#include <string.h>
/*
#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

struct edge
{
  int a, b;
  edge* next;
  edge* back;
};
edge ee[100000];
int nea = 0;
edge* ealloc ()
{
  return &ee[nea++];
}

edge* ve[50000];
int parent[50000];
int pow[50000];

void add_edge (int a, int b)
{
  edge* e1 = ealloc ();
  e1->a = a, e1->b = b, e1->next = ve[a], ve[a] = e1;
  edge* e2 = ealloc ();
  e2->a = b, e2->b = a, e2->next = ve[b], ve[b] = e2;
  e1->back = e2, e2->back = e1;
}
*/
int pow[50000];

int main ()
{
  freopen ("biconn.in", "rt", stdin);
  freopen ("biconn.out", "wt", stdout);

  int n;
  scanf ("%d", &n);
  memset (pow, 0, sizeof pow);
  for (int i = 0; i < n - 1; i++)
  {
    int a, b;
    scanf ("%d %d", &a, &b);
    pow[a - 1]++;
    pow[b - 1]++;
  }
  int count = 0;
  for (int i = 0; i < n; i++)
    if (pow[i] == 1)
      count++;
  printf ("%d\n", (count + 1) / 2);
  int j = -1;
  for (int i = 0; i < n; i++)
  {
    if (pow[i] == 1)
    {
      if (j < 0)
        j = i;
      else
        printf ("%d %d\n", j + 1, i + 1), j = -1;
    }
  }
  if (j >= 1)
    printf ("%d %d\n", 1, j + 1);
  else if (j == 1)
    printf ("%d %d\n", 2, j + 1);

  return 0;
}
