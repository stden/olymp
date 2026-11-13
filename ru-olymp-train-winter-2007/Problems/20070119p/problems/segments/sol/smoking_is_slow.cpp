#include <cstdio>
#include <memory>

using namespace std;

#define HALT(mes) printf(mes); return 0

#define MAXN 25000

struct TPoint 
{
	int x, y;
};

bool operator == (const TPoint& a, const TPoint& b)
{
	return a.x == b.x && a.y == b.y;
}

struct TVector
{
	int x, y;

	TVector(const TPoint& pb, const TPoint& pe) : x(pe.x - pb.x), y(pe.y - pb.y) {};
};

int operator * (const TVector& a, const TVector& b)
{
	return a.x * b.y - a.y * b.x;
}

struct TSegment
{
	TPoint p1, p2;
};

bool segsIntersect(const TSegment& s1, const TSegment& s2)
{
	if (max(s1.p1.x, s1.p2.x) >= min(s2.p1.x, s2.p2.x) && max(s1.p1.y, s1.p2.y) >= min(s2.p1.y, s2.p2.y) &&
		max(s2.p1.x, s2.p2.x) >= min(s1.p1.x, s1.p2.x) && max(s2.p1.y, s2.p2.y) >= min(s1.p1.y, s1.p2.y))
	{
		TVector v12 = TVector(s1.p1, s1.p2);
		TVector v34 = TVector(s2.p1, s2.p2);
		int a = v12 * TVector(s1.p1, s2.p1);
		int b = v12 * TVector(s1.p1, s2.p2);
		int c = v34 * TVector(s2.p1, s1.p1);
		int d = v34 * TVector(s2.p1, s1.p2);
		if (a) a = a / abs(a);
		if (b) b = b / abs(b);
		if (c) c = c / abs(c);
		if (d) d = d / abs(d);
		return a * b <= 0 && c * d <= 0;
	}
	else 
	{
		return false;
	}
}

TSegment seg[MAXN];

int main()
{
	freopen("smoking.in", "r", stdin);
	freopen("smoking.out", "w", stdout);
	
	int n, i, j;

	scanf("%d", &n);
	for (i = 0; i < n; i++)
	{
		scanf("%d %d %d %d", &seg[i].p1.x, &seg[i].p1.y, &seg[i].p2.x, &seg[i].p2.y);
	}

	for (i = 0; i < n; i++)
	{
		for (j = i + 1; j < n; j++)
		{
			if (segsIntersect(seg[i], seg[j]))
			{
				printf("YES\n%d %d", i + 1, j + 1);
				return 0;
			}
		}
	}


	HALT("NO");
}