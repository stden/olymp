#include <stdio.h>
#include <string.h>

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

//#define _DBG_

const int MAX = 32768;
const int MAXD = 128;
const int ALPH = 26;

int next[MAX][ALPH];
int by[MAX];
int parent[MAX];
int suf[MAX];
int prize[MAX];
int root;
int num_v;

int q[MAX];

__int64 dn[MAXD][MAX];
int chr[MAXD][MAX];

void ak_init ()
{
  memset (next, -1, sizeof next);
  memset (by, -1, sizeof by);
  memset (parent, -1, sizeof parent);
  memset (suf, -1, sizeof suf);
  memset (prize, 0, sizeof prize);
  root = 0;
  num_v = 1;
}

void ak_add (char* s, int val)
{
  int curv = root;
  for (int i = 0; s[i]; i++)
  {
    int cur = int (s[i] - 'a');
    if (next[curv][cur] >= 0)
      curv = next[curv][cur];
    else
    {
      int v = num_v++;
      parent[v] = curv;
      next[curv][cur] = v;
      curv = v;
    }
  }
  prize[curv] += val;
}

void ak_build ()
{
  int head = 1;
  int tail = 0;
  q[0] = root;
  while (head > tail)
  {
    int v = q[tail++];
#ifdef _DBG_
    printf ("!proc: %d; ", v);
#endif
    for (int i = 0; i < ALPH; i++)
      if (next[v][i] >= 0)
        q[head++] = next[v][i], by[next[v][i]] = i;
    if (parent[v] < 0)
    {
      suf[v] = 0;
      for (int i = 0; i < ALPH; i++)
        if (next[v][i] < 0)
          next[v][i] = v;
    }
    else
    {
      if (parent[v] == root)
        suf[v] = root;
      else
        suf[v] = next[suf[parent[v]]][by[v]];
#ifdef _DBG_
      printf ("suf: %d; ", suf[v]);
#endif
      for (int i = 0; i < ALPH; i++)
        if (next[v][i] < 0)
          next[v][i] = next[suf[v]][i];
    }
#ifdef _DBG_
    printf ("\n");
#endif
  }
}

__int64 ak_get (int d)
{
  for (int i = 0; i < num_v; i++)
    dn[0][i] = prize[i];
  for (int i = 1; i <= d; i++)
  {
    for (int j = 0; j < num_v; j++)
    {
      __int64 mx = -1;
      for (int k = 0; k < ALPH; k++)
        if (dn[i - 1][next[j][k]] > mx)
          mx = dn[i - 1][next[j][k]],
          chr[i][j] = k;
      dn[i][j] = mx + prize[j];
    }
  }
  return dn[d][root];
}
void ak_print (int d)
{
  int cur = root;
  for (int i = d; i > 0; i--)
  {
    printf ("%c", char ('a' + chr[i][cur]));
    cur = next[cur][chr[i][cur]];
  }
}

char buf[MAX];

int main ()
{
  freopen ("beauty.in", "rt", stdin);
  freopen ("beauty.out", "wt", stdout);

  ak_init ();
  int n;
  scanf ("%d", &n);
  for (int i = 0; i < n; i++)
  {
    int p;
    scanf ("%s %d", buf, &p);
    ak_add (buf, p);
  }
  ak_build ();

#ifdef _DBG_
  printf ("%d\n", num_v);
  for (int i = 0; i < num_v; i++, printf ("\n"))
    for (int j = 0; j < ALPH; j++)
      printf ("%d ", next[i][j]);
#endif

  int d;
  scanf ("%d", &d);

  printf ("%I64d\n", ak_get (d));
  ak_print (d);

  return 0;
}
