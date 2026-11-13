#include <algorithm>
#include <fstream>
#include <iostream>
#include <map>
#include <queue>
#include <set>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

using namespace std;

typedef long long LL;
typedef long double LD;
typedef vector<int> VI;
typedef vector<VI> VVI;
typedef vector<bool> VB;
typedef vector<string> VS;
typedef vector<LL> VLL;
typedef pair<int, int> PII;
typedef vector<PII> VPII;

int _stklen = 30 << 20;

#define F first
#define S second
#define PB push_back
#define MP make_pair

#define ALL(x) (x).begin(), (x).end()
#define SORT(x) sort(ALL(x))
#define SZ(x) (x).size()
#define VAR(x, y) typeof(y) x = (y)
#define ZERO(x) memset(x, 0, sizeof(x))

#define REPN(i, x) for (int i = 0; i < int(x); i++)
#define REPND(i, x) for (int i = int(x) - 1; i >= 0; i--)
#define REPS(i, x) REPN(i, SZ(x))
#define REPSD(i, x) REPND(i, SZ(x))
#define FOR(i, x, y) for (int i = int(x); i <= int(y); i++)
#define FORD(i, x, y) for (int i = int(x); i >= int(y); i--)
#define FORIT(i, x) for (VAR(i, (x).begin()); i != (x).end(); i++)
#define FORITD(i, x) for (VAR(i, (x).rbegin()); i != (x).rend(); i++)

template<class T> T sqr(T x) {
	return x * x;
}

struct Node {
	int x1, x2;
	double f1, f2, s;
	Node *l, *r;

	Node() {
		x1 = x2 = 0;
		f1 = f2 = s = 0.0;
		l = r = NULL;
	}
};

void update(Node *node, int x1, int x2, double f1, double f2) {
	if (x2 < node->x1 || x1 > node->x2) return;
	if (x1 <= node->x1 && x2 >= node->x2) {
		double df1 = f1 + (f2 - f1 + 0.0) / (x2 - x1 + 1.0) * (node->x1 - x1 + 0.0);
		double df2 = f1 + (f2 - f1 + 0.0) / (x2 - x1 + 1.0) * (node->x2 - x1 + 1.0);
		node->f1 += df1;
		node->f2 += df2;
		node->s += (df1 + df2) / 2 * (node->x2 - node->x1 + 1.0);
		return;
	}
	if (!node->l) {
		int middle = (node->x1 + node->x2) / 2;
		node->l = new Node;
		node->r = new Node;
		node->l->x1 = node->x1;
		node->l->x2 = middle;
		node->r->x1 = middle + 1;
		node->r->x2 = node->x2;
	}
	update(node->l, x1, x2, f1, f2);
	update(node->r, x1, x2, f1, f2);
	node->s = node->l->s + node->r->s;
	node->s += (node->f1 + node->f2) / 2 * (node->x2 - node->x1 + 1.0);
}

double query(Node *node, int x1, int x2) {
	if (x2 < node->x1 || x1 > node->x2) return 0;
	if (x1 <= node->x1 && x2 >= node->x2) return node->s;
        if (!node->l) {
		int middle = (node->x1 + node->x2) / 2;
		node->l = new Node;
		node->r = new Node;
		node->l->x1 = node->x1;
		node->l->x2 = middle;
		node->r->x1 = middle + 1;
		node->r->x2 = node->x2;
	}
	double s = query(node->l, x1, x2) + query(node->r, x1, x2);
	x1 >?= node->x1;
	x2 <?= node->x2;
	double f1 = node->f1 + (node->f2 - node->f1 + 0.0) / (node->x2 - node->x1 + 1.0) * (x1 - node->x1 + 0.0);
	double f2 = node->f1 + (node->f2 - node->f1 + 0.0) / (node->x2 - node->x1 + 1.0) * (x2 - node->x1 + 1.0);
	s += (f1 + f2) / 2 * (x2 - x1 + 1.0);
	return s;
}

#define INF (1 << 17)

Node *root;

int main() {
	freopen("geology.in", "rt", stdin);
	freopen("geology.out", "wt", stdout);
	root = new Node;
	root->x1 = 0;
	root->x2 = INF - 1;
	int n;
	scanf("%d", &n);
	REPN(i, n) {
		char buf[100];
		scanf("%s", buf);
		string cmd(buf);
		if (cmd == "ADD") {
			int x, p;
			scanf("%d%d", &x, &p);
			update(root, x - p, x - 1, 0, p);
			update(root, x, x + p - 1, p, 0);
		}
		else {
			int x1, x2;
			scanf("%d%d", &x1, &x2);
			if (x1 > x2) swap(x1, x2);
			if (x1 == x2) printf("0.000\n");
			else printf("%.3f\n", query(root, x1, x2 - 1));
		}
	}
	return 0;
}
