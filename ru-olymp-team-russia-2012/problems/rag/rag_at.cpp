#include <iostream>
#include <fstream>
#include <cmath>
#include <cstdlib>
#include <map>
#include <set>
#include <vector>
#include <cstring>
#include <string>
#include <algorithm>
#include <queue>
#include <cassert>

using namespace std;

struct point {
	int x,y;
	point(int X, int Y): x(X), y(Y) { }
	point() { x = y = 0; }
};

bool operator < (const point& p1, const point& p2) 
{
	if (p1.x == p2.x) 
		return p1.y < p2.y;
	return p1.x < p2.x;
}

bool operator == (const point& p1, const point& p2)
{
	return (p1.x == p2.x) && (p1.y == p2.y);
}

struct event {
	point p1;
	point p2;
	event(const point& _p1, const point& _p2): p1(_p1), p2(_p2)
	{
	}
};

double eps = 1e-9;

double compare_value = 0;

double get(const event& e, double p)
{
	if (e.p1.y == e.p2.y) 
		return 0;
	if (e.p1.x == e.p2.x)
		return e.p1.x;
	double k = (e.p1.y - e.p2.y) / (double)(e.p1.x - e.p2.x);
	double b = e.p1.y - k * e.p1.x;
	return (p - b) / k;
}

double get(const event& e)
{
	return get(e, compare_value);	
}

bool operator < (const event& e1, const event& e2)
{
	double v1 = get(e1);
	double v2 = get(e2);
	if (fabs(v1 - v2) < eps) {
		if (e1.p1 == e2.p1)
			return e1.p2 < e2.p2;
		return e1.p1 < e2.p1;
	}
	return v1 > v2;
}

const int nmax = 1e6;
double w,h;

set <event> e;
map <int,int> mp;
point p[nmax];

vector <event> events;
vector <int> st[nmax];
vector <int> end[nmax];

int main()
{
	freopen("rag.in", "r", stdin);
	freopen("rag.out", "w", stdout);
	cin >> w >> h;
	int n;
	cin >> n;
	vector<int> y;
	for (int i = 0; i < n; i ++)
	{
		cin >> p[i].x >> p[i].y;
		y.push_back(p[i].y);
	}	
	sort(y.begin(), y.end());
	y.resize(unique(y.begin(), y.end()) - y.begin());
	for (int i = 0; i < y.size(); i ++)
		mp[y[i]] = i;
	double res = 0;
	for (int i = 0; i < n - 1; i ++)
	{
		events.push_back(event(p[i], p[i + 1]));
		int y1 = mp[min(p[i].y, p[i + 1].y)];
		int y2 = mp[max(p[i].y, p[i + 1].y)];
		st[y1].push_back(i);
		end[y2].push_back(i);
	}
	for (int i = 0; i + 1 < y.size(); i ++)
	{
		for (int j = 0; j < end[i].size(); j ++)
			e.erase(events[end[i][j]]);
		compare_value = (y[i] + y[i + 1]) / (double) 2;
		for (int j = 0; j < st[i].size(); j ++)
			e.insert(events[st[i][j]]);
		event E = *e.begin();
		if (y[i] >= p[n-1].y)
			res += (w - (get(E, y[i]) + get(E, y[i + 1])) / (double)2) * abs(y[i + 1] - y[i]);
	}
	printf("%.10lf\n", res);
	return 0;
}
