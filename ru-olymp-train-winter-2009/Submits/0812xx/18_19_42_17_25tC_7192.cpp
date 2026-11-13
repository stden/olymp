#include <cstdio>
#include <iostream>
#include <algorithm>
#include <vector>
#include <set>
#include <map>
#include <string>
#include <cstring>
#include <ctime>
#include <memory.h>
#include <cstdlib>

using namespace std;

#define y1 botva
#define forn(i,n) for (int i = 0; i < (int)n; i ++)
#define ford(i,n) for (int i = n-1; i >= 0; i --)
#define l first
#define r second
#define all(x) x.begin(), x.end()
#define last(x) (int)x.size()-1
#define pb push_back
#define mp make_pair
#define ws botva1

typedef long long int64;
typedef long double ldb;

const int inf = (1 << 30) - 1;

struct node
{
  int n, x, y, s, sl;
  node *l, *r;
};

typedef pair < node*, node* > rec;
typedef node* node1;

node t1[400010];
int list, str[200000];

int n, m, a[200010][4];
int fin[400010];
node *rt;

int ls, list2, val[400010];
node* t[524288];
node t2[5000000];

node1 newnode (int num, int x)
{
  node *res;
  res = &t1[list];
  res->y = rand ();
  res->x = x;
  res->n = num;
  res->s = 1;
  res->sl = 0;
  res->l = res->r = NULL;
  list ++;
  return res;
}

node1 newnode1 (int x)
{
  node *res;
  res = &t2[list2];
  res->y = rand ();
  res->x = x;
  res->n = 1;
  res->s = 1;
  res->sl = 0;
  res->l = res->r = NULL;
  list2 ++;
  return res;
}

node1 merge (node1 &l, node1 &r)
{
  if (l == NULL)
    return r;
  if (r == NULL)
    return l;
  if (l->y < r->y)
    {
      l->s += r->s;
      l->r = merge (l->r, r);
      return l;
    }
   else
    {
      r->s += l->s;
      r->l = merge (l, r->l);
      r->sl = r->l->s;
      return r;
    }
}

void split (node1 &v, node1 &l, node1 &r, int x)
{
  if (v == NULL)
    {
      l = NULL;
      r = NULL;
      return;
    }
  if (x <= v->sl)
    {
      r = v;
      split (v->l, l, r->l, x);
      if (l != NULL && r != NULL)
        {
          r->s -= l->s;
          r->sl -= l->s;
        }  
    }
   else
    {
      l = v;
      split (v->r, l->r, r, x- (l->sl +1));
      if (l != NULL && r != NULL)
        l->s -= r->s;
    }
}

void insert (int num, int x, int p)
{
  node *v = newnode (num, x);
  rec q;
  split (rt, q.l, q.r, p);
  rt = merge (q.l, v);
  rt = merge (rt, q.r);
}

int find (node *v, int p)
{
  if (v->sl >= p)
    return find (v->l, p);
   else
  if (v->sl + 1 == p)
    return fin[v->n];
   else
    return find (v->r, p- v->sl-1);
}

int cp;

void go (node *v)
{
  if (v == NULL)
    return;
  go (v->l);
  cp ++;
  fin[v->n] = cp;
  go (v->r);
}

node1 merge1 (node1 l, node1 r)
{
  if (l == NULL)
    return r;
  if (r == NULL)
    return l;
  if (l->y < r->y)
    {
      l->s += r->s;
      l->r = merge1 (l->r, r);
      return l;
    }
   else
    {
      r->s += l->s;
      r->l = merge1 (l, r->l);
      r->sl = r->l->s;
      return r;
    }
}

void erase1 (node1 &v, int x)
{ 
  if (v == NULL)
    return;
  if (v->x == x)
    {
      if (v->n == 1)
        v = merge1 (v->l, v->r);
       else
        {
          v->n --;
          v->s --;
        }  
      return;
    }  
  if (v->x > x)
    {
      erase1 (v->l, x);
      v->s --;
      v->sl --;
    }  
   else 
  if (v->x < x)
    {
      erase1 (v->r, x);
      v->s --;
    }  
}

bool find1 (node1 v, int x)
{
  if (v == NULL)
    return 0;
  if (v->x == x)
    {
      v->n ++;
      v->s ++;
      return true;
    }  
  if (v->x > x)
    {
      if (find1 (v->l, x))
        {
          v->s ++;
          v->sl ++;
          return true;
        }
      return false;  
    } 
  if (v->x < x)
    {
      if (find1 (v->r, x))
        {
          v->s ++;
          return true;
        }
      return false;  
    }
  return false;  
}

void split1 (node1 &v, node1 &l, node1 &r, int x)
{
  if (v == NULL)
    {
      l = NULL;
      r = NULL;
      return;
    }
  if (x <= v->x)
    {
      r = v;
      split1 (v->l, l, r->l, x);
      if (l != NULL && r != NULL)
        {
          r->s -= l->s;
          r->sl -= l->s;
        }  
    }
   else
    {
      l = v;
      split1 (v->r, l->r, r, x);
      if (l != NULL && r != NULL)
        l->s -= r->s;
    }
}

int sum (node *v, int x)
{
  if (v == NULL)
    return 0;
  int qt = 0;
  if (v->x > x)
    return sum (v->l, x);
   else
    return v->sl + v->n + sum (v->r, x); 
}

void insert1 (node1 &rt, int x)
{
  node* v1 = newnode1 (x);
  rec q;
  split1 (rt, q.l, q.r, x);
  rt = merge1 (q.l, v1);
  rt = merge1 (rt, q.r);
}

void ins (int v, int w)
{
  val[v] = w;
  v = v + ls - 1;
  while (v > 0)
    {
      if (!find1 (t[v], w))
        insert1 (t[v], w);
      v >>= 1;
    }
}

void upd (int v, int w)
{
  int v1 = v;
  int w1 = val[v];
  v = v + ls - 1;
  while (v > 0)
    {
      erase1 (t[v], w1);
      if (!find1 (t[v], w))
        insert1 (t[v], w);
      v >>= 1;
    }
  val[v1] = w;
}

int rsq (int v, int l, int r, int a, int b, int p)
{
  if (l > b || r < a)
    return 0;
  if (a <= l && r <= b)
    return sum (t[v], p);
  return rsq (v*2, l, l+r>>1, a, b, p) +
         rsq (v*2+1, (l+r>>1)+1, r, a, b, p);
}

int main ()
{
  freopen ("dynarray.in", "r", stdin);
  freopen ("dynarray.out", "w", stdout);
  srand (63463);
  scanf ("%d%d", &n ,&m);
  rt = NULL;
  list = 0;
  forn (i, n)
    {
      int x;
      scanf ("%d", &x);
      str[i] = x;
      insert (i, x, i);
    }
  forn (i, m)
    {
      int o;
      int x, y, z;
      scanf ("%d", &o);
      a[i][0] = o;
      if (o == 2)
        {
          scanf ("%d%d", &x, &y);
          a[i][1] = x;
          a[i][2] = y;
          insert (i+n, y, x);
        }
       else
      if (o == 1)
        {
          scanf ("%d%d", &x, &y);
          a[i][1] = x;
          a[i][2] = y;
        }  
       else
        {
          scanf ("%d%d%d", &x, &y, &z);
          a[i][1] = x;
          a[i][2] = y;
          a[i][3] = z;
        }  
    }
  cp = 0;  
  memset (fin, 0, sizeof (fin));
  go (rt);  
  
  rt = NULL;
  list = 0;
  ls = 1;
  while (ls < n+m)
    ls *= 2;
  forn (i, ls*2)
    t[i] = NULL;
  list2 = 0;
  forn (i, n)
    {
      int x;
      x = str[i];
      ins (fin[i], x);
      insert (i, x, i);
    }
  forn (i, m)
    {
      int o;
      int x, y, z;
      o = a[i][0];
      if (o == 2)
        {
          x = a[i][1];
          y = a[i][2];
          insert (i+n, y, x);
          ins (fin[i+n], y);
        }
       else
      if (o == 1)
        {
          scanf ("%d%d", &x, &y);
          x = a[i][1];
          y = a[i][2];
          int num = find (rt, x);
          upd (num, y);
        }  
       else
        {
          scanf ("%d%d%d", &x, &y, &z);
          x = a[i][1];
          y = a[i][2];
          z = a[i][3];
          int lf, rg;
          lf = find (rt, x);
          rg = find (rt, y);
          printf ("%d\n", rsq (1, 1, ls, lf, rg, z));
        }  
    }
  cerr << sizeof (t2) << endl;  
  return 0;
}
