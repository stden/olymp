#include <cstdio>
#include <memory>
#include <vector>
#include <algorithm>
#include <set>
#include <cassert>

using namespace std;

#define ALL(x) x.begin(), x.end()

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

	TVector(int dx, int dy) : x(dx), y(dy) {};
	TVector(TPoint pb, TPoint pe) : x(pe.x - pb.x), y(pe.y - pb.y) {};
};

int operator * (const TVector& a, const TVector& b)
{
	return a.x * b.y - a.y * b.x;
}

struct TSegment
{
	TPoint p1, p2;

	int minX() const { return min(p1.x, p2.x); }
	int minY() const { return min(p1.y, p2.y); }
	int maxX() const { return max(p1.x, p2.x); }
	int maxY() const { return max(p1.y, p2.y); }
};

bool operator == (const TSegment& s1, const TSegment& s2)
{
	return s1.p1 == s2.p1 && s1.p2 == s2.p2 ||
		   s1.p1 == s2.p2 && s1.p2 == s2.p1;
}

struct TPointRec
{
	TPoint p;
	int segID;
	bool left;

	TPointRec() {};
	TPointRec(TPoint pp, int ps, bool l) : p(pp), segID(ps), left(l) {};
};

bool operator < (const TPointRec& r1, const TPointRec& r2)
{
	return r1.p.x < r2.p.x || r1.p.x == r2.p.x && r1.p.y < r2.p.y;
}

TSegment seg[MAXN + 1];

struct TSegCmp
{
	bool operator()(int x, int y) const
	{
		TSegment s1 = seg[x];
		TSegment s2 = seg[y];

		if (s1 == s2)
		{
			return false;
		}

		bool q = false; 
		if (s2.p1.x > s1.p1.x)
		{
			swap(s1, s2);
			q = true;
		}

		TVector v(s2.p1, s1.p1);
		TVector u(s2.p1, s2.p2);

		int prod = v * u;
		if (prod)
		{
			return bool(prod > 0) ^ q;
		}
		return x < y;
	}
};

typedef set<int, TSegCmp> SET;
typedef SET::iterator SET_ITER;

SET_ITER next(const SET_ITER& cur)
{
	SET_ITER res = cur;
	return ++res;
}

SET_ITER prev(const SET_ITER& cur)
{
	SET_ITER res = cur;
	return --res;
}

bool segsIntersect(const TSegment& s1, const TSegment& s2)
{
	if (s1.maxX() >= s2.minX() && s2.maxX() >= s1.minX() && 
		s1.maxY() >= s2.minY() && s2.maxY() >= s1.minY())
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

int main()
{
	freopen("smoking.in", "r", stdin);
	freopen("smoking.out", "w", stdout);
	
	int n, i;

	scanf("%d", &n);

	vector<TPointRec> points(2 * n);

	for (i = 1; i <= n; i++)
	{
		scanf("%d %d %d %d", &seg[i].p1.x, &seg[i].p1.y, &seg[i].p2.x, &seg[i].p2.y);

		if (seg[i].p1.x > seg[i].p2.x || seg[i].p1.x == seg[i].p2.x && seg[i].p1.y > seg[i].p2.y)
		{
			swap(seg[i].p1, seg[i].p2);
		}

		points[2 * (i - 1) + 0] = TPointRec(seg[i].p1, i, true);
		points[2 * (i - 1) + 1] = TPointRec(seg[i].p2, i, false);
	}

	sort(ALL(points));
	for (vector<TPointRec>::const_iterator q = points.begin(); (q + 1) != points.end(); q++)
	{
		if (q->p == (q + 1)->p)
		{
			printf("YES\n");
			printf("%d %d\n", q->segID, (q + 1)->segID);
			return 0;
		}
	}

	SET state;
	SET_ITER pos;
	for (vector<TPointRec>::const_iterator q = points.begin(); q != points.end(); q++)
	{
		if (q->left)
		{
/*
			pair<SET_ITER, bool> qqq = state.insert(q->segID);
			assert(qqq.second, "Insertion failed");
			pos = qqq.first;
*/
			pos = (state.insert(q->segID)).first;

			if (pos != state.begin())
			{
				SET_ITER pred = prev(pos);
				if (segsIntersect(seg[*pos], seg[*pred])) 
				{
					printf("YES\n%d %d", *pos, *pred);
					return 0;
				}
			}

			SET_ITER succ = next(pos);
			if (succ != state.end())
			{
				if (segsIntersect(seg[*pos], seg[*succ])) 
				{
					printf("YES\n%d %d", *pos, *succ);
					return 0;
				}
			}
		}
		else 
		{
			pos = state.find(q->segID);

			SET_ITER succ = next(pos);
			if (pos != state.begin() && succ != state.end())
			{
				SET_ITER pred = prev(pos);
				if  (segsIntersect(seg[*pred], seg[*succ]))
				{
					printf("YES\n%d %d", *pred, *succ);
					return 0;
				}
			}

			state.erase(pos);
		}
	}

	printf("NO");

	return 0;
}