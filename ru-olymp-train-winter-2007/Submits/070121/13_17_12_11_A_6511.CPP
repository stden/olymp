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

int _get = 0;

long long get( int v, int ll, int rr )
{
  _get++;
  ll >?= l[v], rr <?= r[v];
  if (ll >= rr)
    return 0;
//  fprintf(stderr, "get(%d %d %d) [%d %d] ty=%d hl=%d hr=%d\n", v, ll, rr, l[v], r[v], ty[v], hl[v], hr[v]);
  if (ll <= l[v] && r[v] <= rr)
    return sum[v];
  if (ty[v] == 2)
  {
    llong ans = 0;
    if (ll < r[vl[v]])
      ans += get(vl[v], ll, rr);
    if (rr > l[vr[v]])
      ans += get(vr[v], ll, rr);
    return ans;
  }
  return (hl[v] + (ll - l[v]) * ty[v] + hl[v] + (rr - l[v]) * ty[v]) * ((llong)rr - ll);
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

int _add = 0;

void addl( int v, int x, int h )
{
  _add++;
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
    if (hl[v] <= h - x + l[v])
      ty[v] = 1, hl[v] = h - x + l[v], hr[v] = h - x + r[v], sum[v] = ((llong)hl[v] + hr[v]) * (r[v] - l[v]);
    else if (l[v] != r[v] - 1 && hr[v] < h - x + r[v])
    {
      split(v);
      addl(vl[v], x, h);
      addl(vr[v], x, h);
      sum[v] = sum[vl[v]] + sum[vr[v]];
    }
  }
  if (l[v] != r[v] - 1 && ty[v] == 2 && ty[vl[v]] != 2 && ty[vl[v]] == ty[vr[v]] && hr[vl[v]] == hl[vr[v]])
    ty[v] = ty[vl[v]];
}

void addr( int v, int x, int h )
{
  _add++;
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
    if (hr[v] <= h - r[v] + x)
      ty[v] = -1, hl[v] = h + x - l[v], hr[v] = h + x - r[v], sum[v] = ((llong)hl[v] + hr[v]) * (r[v] - l[v]);
    else if (l[v] != r[v] - 1 && hl[v] < h - l[v] + x)
    {
      split(v);
      addr(vl[v], x, h);
      addr(vr[v], x, h);
      sum[v] = sum[vl[v]] + sum[vr[v]];
    }
  }
  if (l[v] != r[v] - 1 && ty[v] == 2 && ty[vl[v]] != 2 && ty[vl[v]] == ty[vr[v]] && hr[vl[v]] == hl[vr[v]])
    ty[v] = ty[vl[v]];
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
//    if (!(n % 5000))
//      fprintf(stderr, "%d\n", n);
    char t[6];
    int a, b;
    scanf("%s%d%d", t, &a, &b);
    if (!strcmp(t, "ADD"))
      addl(0, 2 * a, 2 * b), addr(0, 2 * a, 2 * b);
    else
    {
      if (a > b)
        a ^= b, b ^= a, a ^= b;
      llong t = get(0, 2 * a, 2 * b);
      printf("%Ld.%03Ld\n", t / 8, (t % 8) * 125);
    }
  }
  fprintf(stderr, "_add=%d\n", _add);
  fprintf(stderr, "_get=%d\n", _get);
  return 0;
}
