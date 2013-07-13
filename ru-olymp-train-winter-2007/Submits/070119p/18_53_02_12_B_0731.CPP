#include <algorithm>
#include <cstdio>
#include <vector>
#include <set>

using namespace std;

#define PB push_back

#define MAXN 130000
#define EPS 1e-8

struct Segment {
	int x1;
	int y1;
	int x2;
	int y2;
};

struct Event {
	int x;
	int y;
	int i;
	int t;

	Event() {
	}

	Event(int _x, int _y, int _i, int _t) {
		x = _x;
		y = _y;
		i = _i;
		t = _t;
	}
};

bool operator < (const Event &a, const Event &b) {
	if (a.x != b.x) return a.x < b.x;
	if (a.y != b.y) return a.y < b.y;
	return a.t < b.t;
}

int ns;
Segment seg[MAXN];
vector<Event> events;
int cx, cy;

double gety(Segment s, int cx, int cy) {
	if (s.x1 == s.x2) return cy;
	return s.y1 + (cx - s.x1 + 0.0) / (s.x2 - s.x1 + 0.0) * (s.y2 - s.y1 + 0.0);
}

struct Wrap {

	int ind;

	Wrap() {}

	Wrap(int x) {
		ind = x;
	}

};

bool operator < (Wrap a, Wrap b) {
	double y1 = gety(seg[a.ind], cx, cy);
	double y2 = gety(seg[b.ind], cx, cy);
	return y1 < y2 - EPS;
}

set<Wrap> data;

double abs(double x) {
	if (x > 0) return x;
	return -x;
}

bool cross(Segment aa, Segment bb) {
	double a = aa.x2 - aa.x1;
	double b = bb.x1 - aa.x2;
	double c = bb.x1 - aa.x1;
	double d = aa.y2 - aa.y1;
	double e = bb.y1 - aa.y2;
	double f = bb.y1 - aa.y1;
	double dx = c * e - b * f;
	double dy = a * f - c * d;
	double dd = a * e - b * d;
	if (abs(dd) < EPS) return false;
	double t = dx / dd;
	double s = dx / dd;
	return (t > -EPS && t < 1 + EPS && s > -EPS && s < 1 + EPS);
}

void cross(int p, int q) {
	if (p == q) return;
	if (cross(seg[p], seg[q])) {
		printf("YES\n%d %d\n", p + 1, q + 1);
		exit(0);
	}
}

int main() {
	freopen("segments.in", "rt", stdin);
	freopen("segments.out", "wt", stdout);
	scanf("%d", &ns);
	for (int i = 0; i < ns; i++) {
		scanf("%d%d%d%d", &seg[i].x1, &seg[i].y1, &seg[i].x2, &seg[i].y2);
		if (seg[i].x1 > seg[i].x2
		    || (seg[i].x1 == seg[i].x2 && seg[i].y1 > seg[i].y2)) {
			swap(seg[i].x1, seg[i].x2);
			swap(seg[i].y1, seg[i].y2);
		}
		events.PB(Event(seg[i].x1, seg[i].y1, i, -1));
		events.PB(Event(seg[i].x2, seg[i].y2, i, +1));
	}
	sort(events.begin(), events.end());
	for (int i = 0; i < events.size(); i++) {
		cx = events[i].x;
		cy = events[i].y;
		if (events[i].t == -1) {
			data.insert(events[i].i);
			set<Wrap>::iterator it = data.find(events[i].i);
			set<Wrap>::iterator p = it, q = it;
			if (p != data.begin()) p--;
			q++;
			if (q != data.end()) cross(p->ind, q->ind);
			cross(p->ind, events[i].i);
			if (q != data.end()) cross(events[i].i, q->ind);
		}
		else {
			set<Wrap>::iterator it = data.find(events[i].i);
			set<Wrap>::iterator p = it, q = it;
			if (p != data.begin()) p--;
			q++;
			if (q != data.end()) cross(p->ind, q->ind);
			cross(p->ind, events[i].i);
			if (q != data.end()) cross(events[i].i, q->ind);
			data.erase(events[i].i);
		}
	}
	printf("NO\n");
	return 0;
}
