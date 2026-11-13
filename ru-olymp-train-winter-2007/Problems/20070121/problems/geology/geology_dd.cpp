#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <algorithm>
using namespace std;

#define int64 __int64
#define FTC_DEBUG

const int TSIZE = 131072;

inline void Swap(int &a, int &b)
{
	int t = a;
	a = b;
	b = t;
}

inline void Swap(int64 &a, int64 &b)
{
	int64 t = a;
	a = b;
	b = t;
}

inline int64 abs(int64 a)
{
	return a < 0 ? -a : a;
}

int64 sum[2 * TSIZE + 1];
int64 lval[2 * TSIZE + 1], rval[2 * TSIZE + 1];
int otr[2 * TSIZE + 1][2];

void GenT(int ver)
{
	if (ver >= TSIZE)
	{
		otr[ver][0] = otr[ver][1] = ver - TSIZE + 1;
		return;
	}
	GenT(2 * ver);
	GenT(2 * ver + 1);
	otr[ver][0] = otr[2 * ver][0];
	otr[ver][1] = otr[2 * ver + 1][1];
}

void Load()                      
{
	GenT(1);
	int i;
	for (i = 1; i <= 2 * TSIZE; i++)
	{
		sum[i] = 0;
		lval[i] = rval[i] = 0;
	}
}

void FlushAdd(int ver)
{
	if ((lval[ver] == 0) && (rval[ver] == 0)) return;
	if (ver >= TSIZE)
	{
		sum[ver] += lval[ver];
		lval[ver] = rval[ver] = 0;
		return;
	}
	int bn;
	int64 vn;
	bn = otr[2 * ver][1];
	vn = (rval[ver] - lval[ver]) * (bn - otr[ver][0]) / (otr[ver][1] - otr[ver][0]) + lval[ver];
	lval[2 * ver] += lval[ver];
	rval[2 * ver] += vn;
	bn++;
	vn = (rval[ver] - lval[ver]) * (bn - otr[ver][0]) / (otr[ver][1] - otr[ver][0]) + lval[ver];
	lval[2 * ver + 1] += vn;
	rval[2 * ver + 1] += rval[ver];
	if (lval[ver] > rval[ver]) Swap(lval[ver], rval[ver]);
	sum[ver] += (rval[ver] + lval[ver]) * (otr[ver][1] - otr[ver][0] + 1) / 2;
	lval[ver] = rval[ver] = 0;
}

void AddLinFunc(int ver, int be, int en, int64 vl, int64 vr)
{
	#ifdef FTC_DEBUG
	//printf("Added to ver %d be %d en %d vl %I64d vr %I64d\n", ver, be, en, vl, vr);
	#endif
	FlushAdd(ver);
	if (ver >= TSIZE)
	{
		sum[ver] += vl;
		return;
	}
	if ((otr[ver][0] == be) && (otr[ver][1] == en))
	{
		lval[ver] += vl;
		rval[ver] += vr;
		return;
	}
	int bn;
	int64 vn;
	if (be <= otr[2 * ver][1])
	{
		bn = min(otr[2 * ver][1], en);
		if (en == be) vn = vl;
		else vn = (vr - vl) * (bn - be) / (en - be) + vl;
		AddLinFunc(2 * ver, be, bn, vl, vn);
	}
	if (en >= otr[2 * ver + 1][0])
	{
		bn = max(otr[2 * ver + 1][0], be);
		if (en == be) vn = vl;
		else vn = (vr - vl) * (bn - be) / (en - be) + vl;
		AddLinFunc(2 * ver + 1, bn, en, vn, vr);
	}
 	sum[ver] += abs(vl + vr) * (en - be + 1) / 2;
}

int64 GetSum(int ver, int be, int en)
{
	FlushAdd(ver);
	if (ver >= TSIZE)
	{
		return sum[ver];
	}
	if ((otr[ver][0] == be) && (otr[ver][1] == en))
	{
		return sum[ver];
	}
	int bn;
	int64 res = 0;
	if (be <= otr[2 * ver][1])
	{
		bn = min(otr[2 * ver][1], en);
		res += GetSum(2 * ver, be, bn);
	}
	if (en >= otr[2 * ver + 1][0])
	{
		bn = max(otr[2 * ver + 1][0], be);
		res += GetSum(2 * ver + 1, bn, en);
	}
	return res;
}

void OutRes(int64 res)
{
	int64 a = res / 2;
	printf("%I64d", a);
	if (res % 2 == 1) printf(".500");
	else printf(".000");
}

void Solve()
{
	int n, i;
	scanf("%d", &n);
	for (i = 0; i < n; i++)
	{

		char c = getchar();
		while ((c < 'A') || (c > 'Z')) c = getchar();
		if (c == 'A')
		{
			c = getchar();
			c = getchar();
			int x, p;
			scanf("%d%d", &x, &p);
			int xr, xl;
			int64 vl, vr;
			if (x != 1)
			{
				xr = x - 1;
				xl = x - p;
				vl = 1;
				vr = 2 * p - 1;
				if (xl < 1)
				{
					xl = 1;
					vl = vr - abs(xl - xr) * 2;
				}
				AddLinFunc(1, xl, xr, vl, vr);
			}
			xl = x;
			xr = x + p - 1;
			vl = 2 * p - 1;
			vr = 1;
			if (xr > TSIZE)
			{
				xr = TSIZE;
				vr = vl - abs(xl - xr) * 2;
			}
			AddLinFunc(1, xl, xr, vl, vr);
		}
		else
		{
			c = getchar();
			c = getchar();
			c = getchar();
			c = getchar();
			int x1, x2;
			scanf("%d%d", &x1, &x2);
			if (x1 == x2)
			{
				printf("0.000\n");
			}
			else
			{
				if (x1 > x2) Swap(x1, x2);
				x2--;
				int64 res = GetSum(1, x1, x2);
				OutRes(res);
				printf("\n");
			}
		}
	}
}

int main()
{
	freopen("geology.in", "rt", stdin);
	freopen("geology.out", "wt", stdout);
	Load();
	Solve();
	return 0;
}    