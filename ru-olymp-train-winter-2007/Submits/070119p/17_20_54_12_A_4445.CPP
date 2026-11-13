#include <algorithm>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>

using namespace std;

#define EPS 1e-8

typedef double D;

D xx1, yy1, xx2, yy2, xx3, yy3;
D xx4, yy4, xx5, yy5, xx6, yy6;
int np, np1;
D px[10], py[10];

void addp(D cx, D cy) {
	px[np] = cx;
	py[np] = cy;
	np++;
}

D abs(D x) {
	if (x > 0) return x;
	return -x;
}

void cross(D x1, D y1, D x2, D y2, D x3, D y3, D x4, D y4) {
	D a = x2 - x1;
	D b = x3 - x4;
	D c = x3 - x1;
	D d = y2 - y1;
	D e = y3 - y4;
	D f = y3 - y1;
	D dx = c * e - b * f;
	D dd = a * e - b * d;
	if (abs(dd) < EPS) return;
	D t = dx / dd;
	addp(x1 + (x2 - x1) * t, y1 + (y2 - y1) * t);
}

D vect(D x1, D y1, D x2, D y2) {
	return x1 * y2 - x2 * y1;
}

int sign(D x) {
	if (x > EPS) return 1;
	if (x < -EPS) return -1;
	return 0;
}

bool inside(D x0, D y0, D x1, D y1, D x2, D y2, D x3, D y3) {
	int po = 0, ot = 0;
	int s1 = sign(vect(x0 - x1, y0 - y1, x2 - x1, y2 - y1));
	int s2 = sign(vect(x0 - x2, y0 - y2, x3 - x2, y3 - y2));
	int s3 = sign(vect(x0 - x3, y0 - y3, x1 - x3, y1 - y3));
	if (s1 > 0) po++;
	if (s2 > 0) po++;
	if (s3 > 0) po++;
	if (s1 < 0) ot++;
	if (s2 < 0) ot++;
	if (s3 < 0) ot++;
	return !po || !ot;
}

D dist(D x1, D y1, D x2, D y2) {
	return sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
}

bool less(D x0, D y0, D x1, D y1, D x2, D y2) {
	int v = sign(vect(x1 - x0, y1 - y0, x2 - x1, y2 - y1));
	if (v != 0) return v == 1;
	double d1 = dist(x0, y0, x1, y1);
	double d2 = dist(x0, y0, x2, y2);
	return d1 < d2;
}

int main() {
	freopen("triangle.in", "r", stdin);
	freopen("triangle.out", "w", stdout);
	scanf("%lf%lf%lf%lf%lf%lf", &xx1, &yy1, &xx2, &yy2, &xx3, &yy3);
	scanf("%lf%lf%lf%lf%lf%lf", &xx4, &yy4, &xx5, &yy5, &xx6, &yy6);
	np = 0;

	cross(xx1, yy1, xx2, yy2, xx4, yy4, xx5, yy5);
	cross(xx1, yy1, xx2, yy2, xx5, yy5, xx6, yy6);
	cross(xx1, yy1, xx2, yy2, xx4, yy4, xx6, yy6);

	cross(xx2, yy2, xx3, yy3, xx4, yy4, xx5, yy5);
	cross(xx2, yy2, xx3, yy3, xx5, yy5, xx6, yy6);
	cross(xx2, yy2, xx3, yy3, xx4, yy4, xx6, yy6);

	cross(xx3, yy3, xx1, yy1, xx4, yy4, xx5, yy5);
	cross(xx3, yy3, xx1, yy1, xx5, yy5, xx6, yy6);
	cross(xx3, yy3, xx1, yy1, xx4, yy4, xx6, yy6);

	addp(xx1, yy1);
	addp(xx2, yy2);
	addp(xx3, yy3);
	addp(xx4, yy4);
	addp(xx5, yy5);
	addp(xx6, yy6);
	
	np1 = 0;

	for (int i = 0; i < np; i++) {
		if (!inside(px[i], py[i], xx1, yy1, xx2, yy2, xx3, yy3) || !inside(px[i], py[i], xx4, yy4, xx5, yy5, xx6, yy6)) continue;
		px[np1] = px[i];
		py[np1] = py[i];
		np1++;
	}

	for (int i = 1; i < np - 1; i++) {
		for (int j = i + 1; j < np; j++) {
			if (less(px[0], py[0], px[j], py[j], px[i], py[i])) {
				swap(px[i], px[j]);
				swap(py[i], py[j]);
			}
		}
	}
	D s = 0;
	for (int i = 0; i < np1; i++) {
		s += vect(px[i], py[i], px[(i + 1) % np1], py[(i + 1) % np1]);
	}
	s = abs(s) / 2;
	D s1 = abs(vect(xx2 - xx1, yy2 - yy1, xx3 - xx1, yy3 - yy1) / 2);
	D s2 = abs(vect(xx5 - xx4, yy5 - yy4, xx6 - xx4, yy6 - yy4) / 2);
	printf("%.3lf\n", s1 + s2 - s);
	return 0;
}
