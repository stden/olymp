#define _CRT_SECURE_NO_DEPRECATE
#include <cassert>
#include <cstdio>
#include <cstdlib>
#include <vector>

using namespace std;

#define MAXN 200000
#define MAXM 200000
#define MAXC 1000000
#define LGMAX 20

struct Query {
	int cmd;
	int p, q, r;
	int aux1, aux2;
};

struct RopeNode {
	int data;
	int priority;
	int amount;
	RopeNode *l, *r;

	RopeNode() {}

	RopeNode(int data):
		data(data),
		priority(rand()),
		amount(1),
		l(0),
		r(0) {
	}
};

RopeNode ropePool[MAXN + MAXM];
RopeNode *firstRope;

RopeNode *newRope(int data) {
	RopeNode *res = firstRope;
	firstRope = firstRope->l;
	res->data = data;
	res->priority = rand();
	res->amount = 1;
	res->l = 0;
	res->r = 0;
	return res;
}

struct Rope {
	RopeNode *root;

	Rope():
		root(0) {
	}

	int getAmount(RopeNode *node) {
		if (!node) return 0;
		return node->amount;
	}

	void recalc(RopeNode *node) {
		if (!node) return;
		node->amount = getAmount(node->l) + getAmount(node->r) + 1;
	}

	void split(RopeNode *node, int cut, RopeNode *&left, RopeNode *&right) {
		assert(cut >= 0);
		assert(cut <= getAmount(node));
		if (!node) {
			left = right = 0;
		}
		else if (cut <= getAmount(node->l)) {
			split(node->l, cut, left, node->l);
			right = node;
		}
		else {
			split(node->r, cut - getAmount(node->l) - 1, node->r, right);
			left = node;
		}
		recalc(left);
		recalc(right);
	}

	RopeNode *merge(RopeNode *left, RopeNode *right) {
		RopeNode *res;
		if (!left) res = right;
		else if (!right) res = left;
		else if (left->priority > right->priority) {
			left->r = merge(left->r, right);
			res = left;
		}
		else {
			right->l = merge(left, right->l);
			res = right;
		}
		recalc(res);
		return res;
	}

	void insert(int pos, int data) {
		assert(pos >= 0);
		assert(pos <= getAmount(root));
		RopeNode *left, *right;
		split(root, pos, left, right);
		root = merge(left, newRope(data));
		root = merge(root, right);
	}

	RopeNode *get(RopeNode *node, int k) {
		assert(k >= 1);
		assert(k <= getAmount(node));
		if (k <= getAmount(node->l)) return get(node->l, k);
		if (k == getAmount(node->l) + 1) return node;
		return get(node->r, k - getAmount(node->l) - 1);
	}

	int getKth(int k) {
		assert(k >= 1);
		assert(k <= getAmount(root));
		return get(root, k)->data;
	}

	void dump(RopeNode *node, vector<int> &res) {
		if (!node) return;
		dump(node->l, res);
		res.push_back(node->data);
		dump(node->r, res);
	}

	vector<int> dump() {
		vector<int> res;
		dump(root, res);
		return res;
	}
};

struct TreeNode {
	int data;
	int times;
	int priority;
	int amount;
	TreeNode *l, *r;

	TreeNode() {}

	TreeNode(int data):
		data(data),
		times(1),
		priority(rand()),
		amount(1),
		l(0),
		r(0) {
	}
};

TreeNode treePool[(MAXN + MAXM) * LGMAX];
TreeNode *firstTree;

TreeNode *newTree(int data) {
	TreeNode *res = firstTree;
	firstTree = firstTree->l;
	res->data = data;
	res->times = 1;
	res->priority = rand();
	res->amount = 1;
	res->l = 0;
	res->r = 0;
	return res;
}

void releaseTree(TreeNode *node) {
	node->l = firstTree;
	firstTree = node;
}

struct Tree {
	TreeNode *root;

	Tree():
		root(0) {
	}

	TreeNode *find(TreeNode *node, int data) {
		if (!node || node->data == data) return node;
		if (data < node->data) return find(node->l, data);
		return find(node->r, data);
	}

	int getAmount(TreeNode *node) {
		if (!node) return 0;
		return node->amount;
	}

	void recalc(TreeNode *node) {
		if (!node) return;
		node->amount = getAmount(node->l) + getAmount(node->r) + node->times;
	}

	void split(TreeNode *node, int data, TreeNode *&left, TreeNode *&right) {
		if (!node) {
			left = right = 0;
		}
		else if (data < node->data) {
			split(node->l, data, left, node->l);
			right = node;
		}
		else {
			split(node->r, data, node->r, right);
			left = node;
		}
		recalc(left);
		recalc(right);
	}

	void insert(TreeNode *&root, TreeNode *node) {
		if (!root || node->priority > root->priority) {
			split(root, node->data, node->l, node->r);
			root = node;
		}
		else if (node->data < root->data) {
			insert(root->l, node);
		}
		else {
			insert(root->r, node);
		}
		recalc(root);
	}

	void updateTimes(TreeNode *node, int data) {
		assert(node);
		if (node->data == data) {
			node->times++;
		}
		else if (data < node->data) {
			updateTimes(node->l, data);
		}
		else {
			updateTimes(node->r, data);
		}
		recalc(node);
	}

	void updateTimes1(TreeNode *node, int data) {
		assert(node);
		if (node->data == data) {
			node->times--;
		}
		else if (data < node->data) {
			updateTimes(node->l, data);
		}
		else {
			updateTimes(node->r, data);
		}
		recalc(node);
	}

	void insert(int data) {
		TreeNode *node = find(root, data);
		if (node) {
			updateTimes(root, data);
		}
		else {
			insert(root, newTree(data));
		}
	}

	TreeNode *merge(TreeNode *left, TreeNode *right) {
		TreeNode *res;
		if (!left) res = right;
		else if (!right) res = left;
		else if (left->priority > right->priority) {
			left->r = merge(left->r, right);
			res = left;
		}
		else {
			right->l = merge(left, right->l);
			res = right;
		}
		recalc(res);
		return res;
	}

	void remove(TreeNode *&root, int data) {
		assert(root);
		if (root->data == data) {
			root->times--;
			if (!root->times) {
				TreeNode *tmp = root;
				root = merge(root->l, root->r);
				releaseTree(tmp);
			}
		}
		else if (data < root->data) {
			remove(root->l, data);
		}
		else {
			remove(root->r, data);
		}
		recalc(root);
	}

	void remove(int data) {
		remove(root, data);
	}

	int howMany(TreeNode *node, int data) {
		if (!node) return 0;
		if (data < node->data) return howMany(node->l, data);
		int res = getAmount(node->l);
		if (data >= node->data) res += node->times;
		if (data > node->data) res += howMany(node->r, data);
		return res;
	}

	int howMany(int data) {
		return howMany(root, data);
	}

	void debug(TreeNode *node) {
		if (!node) return;
		debug(node->l);
		printf("(%d, %d) ", node->data, node->times);
		debug(node->r);
	}

	void debug() {
		debug(root);
		printf("\n");
	}
};

int n, m, nb;
int a[MAXN], src[MAXN];
Query query[MAXM];
int b[MAXN + MAXM];
Tree seg[4 * (MAXN + MAXM)];

int transformAux(int aux) {
	if (aux < 0) {
		return src[-aux - 1];
	}
	return query[aux].aux1;
}

void buildTree(int x, int l0, int r0) {
	for (int i = l0; i <= r0; i++) {
		seg[x].insert(b[i]);
	}
	if (l0 == r0) return;
	int m = (l0 + r0) / 2;
	buildTree(2 * x + 1, l0, m);
	buildTree(2 * x + 2, m + 1, r0);
}

void updateTree(int x, int l0, int r0, int pos, int what) {
	if (pos < l0 || pos > r0) return;
	seg[x].remove(b[pos]);
	seg[x].insert(what);
	if (l0 == r0) return;
	int m = (l0 + r0) / 2;
	updateTree(2 * x + 1, l0, m, pos, what);
	updateTree(2 * x + 2, m + 1, r0, pos, what);
}

int queryTree(int x, int l0, int r0, int l, int r, int what) {
	if (l > r0 || r < l0) return 0;
	if (l <= l0 && r >= r0) {
		return seg[x].howMany(what);
	}
	int m = (l0 + r0) / 2;
	int res1 = queryTree(2 * x + 1, l0, m, l, r, what);
	int res2 = queryTree(2 * x + 2, m + 1, r0, l, r, what);
	return res1 + res2;
}

int main() {
	for (int i = 0; i < MAXN + MAXM - 1; i++) {
		ropePool[i].l = &ropePool[i + 1];
	}
	firstRope = &ropePool[0];
	for (int i = 0; i < (MAXN + MAXM) * LGMAX - 1; i++) {
		treePool[i].l = &treePool[i + 1];
	}
	firstTree = &treePool[0];
	srand(0xdead);
	freopen("dynarray.in", "r", stdin);
	freopen("dynarray.out", "w", stdout);
	scanf("%d%d", &n, &m);
	assert(n >= 1);
	assert(n <= MAXN);
	assert(m >= 1);
	assert(m <= MAXM);
	for (int i = 0; i < n; i++) {
		scanf("%d", &a[i]);
		assert(a[i] >= 0);
		assert(a[i] <= MAXC);
	}
	int cur_n = n;
	for (int i = 0; i < m; i++) {
		scanf("%d", &query[i].cmd);
		if (query[i].cmd == 1) {
			scanf("%d%d", &query[i].p, &query[i].q);
			assert(query[i].p >= 1);
			assert(query[i].p <= cur_n);
			assert(query[i].q >= 0);
			assert(query[i].q <= MAXC);
		}
		else if (query[i].cmd == 2) {
			scanf("%d%d", &query[i].p, &query[i].q);
			assert(query[i].p >= 0);
			assert(query[i].p <= cur_n);
			assert(query[i].q >= 0);
			assert(query[i].q <= MAXC);
			cur_n++;
		}
		else {
			assert(query[i].cmd == 3);
			scanf("%d%d%d", &query[i].p, &query[i].q, &query[i].r);
			assert(1 <= query[i].p);
			assert(query[i].p <= query[i].q);
			assert(query[i].q <= cur_n);
			assert(query[i].r >= 0);
			assert(query[i].r <= MAXC);
		}
	}
	Rope rope;
	for (int i = 0; i < n; i++) {
		rope.insert(i, -i - 1);
	}
	for (int i = 0; i < m; i++) {
		if (query[i].cmd == 1) {
			query[i].aux1 = rope.getKth(query[i].p);
		}
		else if (query[i].cmd == 2) {
			rope.insert(query[i].p, i);
		}
		else {
			query[i].aux1 = rope.getKth(query[i].p);
			query[i].aux2 = rope.getKth(query[i].q);
		}
	}
	vector<int> final = rope.dump();
	for (int i = 0; i < int(final.size()); i++) {
		if (final[i] < 0) {
			src[-final[i] - 1] = i;
		}
		else {
			query[final[i]].aux1 = i;
		}
	}
	for (int i = 0; i < m; i++) {
		if (query[i].cmd == 1) {
			query[i].aux1 = transformAux(query[i].aux1);
		}
		else if (query[i].cmd == 3) {
			query[i].aux1 = transformAux(query[i].aux1);
			query[i].aux2 = transformAux(query[i].aux2);
		}
	}
	nb = final.size();
	for (int i = 0; i < nb; i++) {
		b[i] = MAXC + 1;
	}
	for (int i = 0; i < n; i++) {
		b[src[i]] = a[i];
	}
	buildTree(0, 0, nb - 1);
	for (int i = 0; i < m; i++) {
		if (query[i].cmd != 3) {
			updateTree(0, 0, nb - 1, query[i].aux1, query[i].q);
			b[query[i].aux1] = query[i].q;
		}
		else {
			int ans = queryTree(0, 0, nb - 1, query[i].aux1, query[i].aux2, query[i].r);
			printf("%d\n", ans);
		}
	}
	return 0;
}
