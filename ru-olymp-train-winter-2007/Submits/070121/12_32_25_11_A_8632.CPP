#include <cstdio>
#include <cstring>

typedef long long llong;

#define abs(a) ((a) > 0 ? (a) : -(a))

#define m 200100
#define mm (m + m)

int n, nv, l[mm], r[mm], vl[mm], vr[mm], hl[mm], hr[mm], ty[mm];
llong sum[mm];

void prep( int v, int ll, int rr )
{
  l[v] = ll, r[v] = rr, ty[v] = 0, vl[v] = vr[v] = -1, hl[v] = hr[v] = 0;
  if (ll == rr - 1)
    return;
  int e = (ll + rr) / 2;
  vl[v] = nv++, vr[v] = nv++;
  prep(vl[v], ll, e);
  prep(vr[v], e, rr);
}

long long get( int v, int ll, int rr )
{
//  fprintf(stderr, "get(%d %d %d)\n", v, ll, rr);
  if (ll <= l[v] && r[v] <= rr)
    return sum[v];
  if (rr <= l[v] || ll >= r[v])
    return 0;
  ll >?= l[v], rr <?= r[v];
  if (ty[v] != 2)
    return (hl[v] + (ll - l[v]) * ty[v] + hl[v] + (rr - l[v]) * ty[v]) * ((llong)rr - ll);
  return get(vl[v], ll, rr) + get(vr[v], ll, rr);
}

void split( int v )
{
  if (ty[v] != 2)
  {
    ty[vl[v]] = ty[v], hl[vl[v]] = hl[v], hr[vl[v]] = hl[v] + ty[v] * (r[vl[v]] - l[v]);
    sum[vl[v]] = ((llong)hl[vl[v]] + hr[vl[v]]) * (r[vl[v]] - l[vl[v]]);
    ty[vr[v]] = ty[v], hr[vr[v]] = hr[v], hl[vr[v]] = hr[v] + ty[v] * (l[vr[v]] - r[v]);
    sum[vr[v]] = ((llong)hl[vr[v]] + hl[vr[v]]) * (r[vr[v]] - l[vr[v]]);
    ty[v] = 2;
  }
}

void addl( int v, int x, int h )
{
//  fprintf(stderr, "addl(%d %d %d)\n", v, x, h);
  if (x <= l[v])
    return;
  else if (x < r[v])
  {
    split(v);
    addl(vl[v], x, h);
    addl(vr[v], x, h);
    sum[v] = sum[vl[v]] + sum[vr[v]];
    hl[v] = hl[vl[v]], hr[v] = hr[vr[v]];
  }
  else
  {
    if (hl[v] + r[v] - l[v] <= h - x + r[v])
      ty[v] = 1, hl[v] = h - x + l[v], hr[v] = hl[v] + r[v] - l[v], sum[v] = ((llong)hl[v] + hr[v]) * (r[v] - l[v]);
    else if (l[v] != r[v] - 1)
    {
      split(v);
      addl(vl[v], x, h);
      addl(vr[v], x, h);
    }
  }
}

void addr( int v, int x, int h )
{
//  fprintf(stderr, "addr(%d %d %d)\n", v, x, h);
  if (x >= r[v])
    return;
  else if (x > l[v])
  {
    split(v);
    addr(vl[v], x, h);
    addr(vr[v], x, h);
    sum[v] = sum[vl[v]] + sum[vr[v]];
    hl[v] = hl[vl[v]], hr[v] = hr[vr[v]];
  }
  else
  {
    if (hr[v] + r[v] - l[v] <= h - x + r[v])
      ty[v] = -1, hl[v] = h - x + l[v], hr[v] = hl[v] - r[v] + l[v], sum[v] = ((llong)hl[v] + hr[v]) * (r[v] - l[v]);
    else if (l[v] != r[v] - 1)
    {
      split(v);
      addr(vl[v], x, h);
      addr(vr[v], x, h);
    }
  }
}

int main( void )
{
  freopen("geology.in", "rt", stdin);
  freopen("geology.out", "wt", stdout);
  nv = 1;
  prep(0, 0, m);
  scanf("%d", &n);
  while (n--)
  {
    char t[6];
    int a, b;
    scanf("%s%d%d", t, &a, &b);
    if (!strcmp(t, "ADD"))
      addl(0, 2 * a, 2 * b), addr(0, 2 * a, 2 * b);
    else
    {
      llong t = get(0, 2 * a, 2 * b);
      printf("%Ld.%03Ld\n", t / 8, (t % 8) * 125);
    }
  }
  return 0;
}
