#define _CRT_SECURE_NO_DEPRECATE

#include <algorithm>
#include <cassert>
#include <cstdio>
#include <iostream>
#include <queue>
#include <set>
#include <utility>
#include <vector>

#define MAXN 50
#define MAXM 300
#define MAXK 300
#define MAXC 1000000000
#define INFINITY 1000000000000000ll
#define RATIO 7

typedef long long ll;

struct Arc {
	int tail, head;
	ll capacity, flow;
	bool auxillary;
	Arc *reverse, *next_out, *prev_out, *next_in, *prev_in;

	Arc(int tail, int head, ll capacity, bool auxillary):
		tail(tail),
		head(head),
		capacity(capacity),
		flow(0),
		auxillary(auxillary),
		reverse(0) {
		next_out = this;
		prev_out = this;
		next_in = this;
		prev_in = this;
	}
};

struct Node {
	int id;
	Arc *outgoing, *ingoing, *current_outgoing;
	int label;
	ll excess;
	Node *next, *prev;
	bool visited;
};

struct CutSet {
	std::vector<int> mask;
	std::vector<int> optimal;
	ll optimal_cost;

	CutSet(const std::vector<int> &mask): mask(mask) {
	}
};

bool operator < (const CutSet &a, const CutSet &b) {
	return a.optimal_cost > b.optimal_cost;
}

int n, m;
Node *node[MAXN];
Node *bucket[2 * MAXN];
std::priority_queue<CutSet> cutsets;
int counter = 0;

bool is_admissible(Arc *arc) {
	return arc->flow < arc->capacity && node[arc->tail]->label == node[arc->head]->label + 1;
}

void push(Arc *arc) {
	counter++;
	ll delta = std::min(node[arc->tail]->excess, arc->capacity - arc->flow);
	arc->flow += delta;
	arc->reverse->flow -= delta;
	node[arc->tail]->excess -= delta;
	node[arc->head]->excess += delta;
	if (node[arc->head]->excess == delta) {
		if (arc->head != 0 && arc->head != n - 1) {
			node[arc->head]->prev = bucket[node[arc->head]->label];
			node[arc->head]->next = node[arc->head]->prev->next;
			node[arc->head]->prev->next = node[arc->head];
			node[arc->head]->next->prev = node[arc->head];
		}
	}
}

void relabel(int v) {
	node[v]->label = 2 * n;
	for (Arc *arc = node[v]->outgoing->next_out; arc != node[v]->outgoing; arc = arc->next_out) {
		counter++;
		if (arc->flow < arc->capacity && node[arc->head]->label + 1 < node[v]->label) {
			node[v]->label = node[arc->head]->label + 1;
		}
	}
}

void discharge(int v) {
	bool time_to_relabel = false;
	do {
		if (is_admissible(node[v]->current_outgoing)) {
			push(node[v]->current_outgoing);
		}
		else if (node[v]->current_outgoing->next_out != node[v]->outgoing) {
			node[v]->current_outgoing = node[v]->current_outgoing->next_out;
		}
		else {
			node[v]->current_outgoing = node[v]->outgoing->next_out;
			time_to_relabel = true;
		}
	} while (node[v]->excess != 0 && !time_to_relabel);
	if (time_to_relabel) {
		relabel(v);
	}
}

void add_arc(int tail, int head, ll capacity, bool auxillary) {
	Arc *a = new Arc(tail, head, capacity, auxillary);
	Arc *b = new Arc(head, tail, 0, auxillary);

	a->prev_out = node[tail]->outgoing;
	a->next_out = a->prev_out->next_out;
	a->prev_out->next_out = a;
	a->next_out->prev_out = a;

	b->prev_out = node[head]->outgoing;
	b->next_out = b->prev_out->next_out;
	b->prev_out->next_out = b;
	b->next_out->prev_out = b;

	a->prev_in = node[head]->ingoing;
	a->next_in = a->prev_in->next_in;
	a->prev_in->next_in = a;
	a->next_in->prev_in = a;

	b->prev_in = node[tail]->ingoing;
	b->next_in = b->prev_in->next_in;
	b->prev_in->next_in = b;
	b->next_in->prev_in = b;

	a->reverse = b;
	b->reverse = a;
}

void global_relabeling() {
	for (int i = 0; i < n; i++) {
		node[i]->visited = false;
	}
	std::queue<int> q;
	q.push(n - 1);
	node[n - 1]->visited = true;
	/*
	node[n - 1]->label = 0;
	*/
	while (!q.empty()) {
		int cur = q.front();
		if (cur == 0) {
			continue;
		}
		q.pop();
		for (Arc *arc = node[cur]->ingoing->next_in; arc != node[cur]->ingoing; arc = arc->next_in) {
			if (arc->flow < arc->capacity && !node[arc->tail]->visited) {
				node[arc->tail]->visited = true;
				/*
				node[arc->tail]->prev->next = node[arc->tail]->next;
				node[arc->tail]->next->prev = node[arc->tail]->prev;
				fprintf(stderr, "%d\n", node[arc->tail]->label);
				*/
				/*
				node[arc->tail]->label = node[cur]->label + 1;
				*/
				/*
				node[arc->tail]->prev = bucket[node[arc->tail]->label];
				node[arc->tail]->next = node[arc->tail]->prev->next;
				node[arc->tail]->prev->next = node[arc->tail];
				node[arc->tail]->next->prev = node[arc->tail];
				*/
				q.push(arc->tail);
			}
		}
	}
	/*
	for (int i = 1; i < n - 1; i++) {
		if (node[i]->visited) {
			continue;
		}
		node[i]->prev->next = node[i]->next;
		node[i]->next->prev = node[i]->prev;
		node[i]->label = n + 1;
		node[i]->prev = bucket[node[i]->label];
		node[i]->next = node[i]->prev->next;
		node[i]->prev->next = node[i];
		node[i]->next->prev = node[i];
	}
	*/
}

void process(CutSet &cutset) {
	for (int i = 1; i < n - 1; i++) {
		if (cutset.mask[i] == 0) {
			add_arc(0, i, INFINITY, true);
		}
		if (cutset.mask[i] == 1) {
			add_arc(i, n - 1, INFINITY, true);
		}
	}
	for (int i = 0; i < n; i++) {
		for (Arc *arc = node[i]->outgoing->next_out; arc != node[i]->outgoing; arc = arc->next_out) {
			arc->flow = 0;
		}
		node[i]->label = 0;
		node[i]->excess = 0;
		node[i]->current_outgoing = node[i]->outgoing->next_out;
	}
	node[0]->label = n;
	for (Arc *arc = node[0]->outgoing->next_out; arc != node[0]->outgoing; arc = arc->next_out) {
		arc->flow = arc->capacity;
		arc->reverse->flow = -arc->flow;
		node[arc->head]->excess += arc->flow;
	}
	for (int i = 0; i < 2 * n; i++) {
		bucket[i]->next = bucket[i];
		bucket[i]->prev = bucket[i];
	}
	for (int i = 1; i < n - 1; i++) {
		if (node[i]->excess == 0) {
			continue;
		}
		node[i]->prev = bucket[0];
		node[i]->next = node[i]->prev->next;
		node[i]->prev->next = node[i];
		node[i]->next->prev = node[i];
	}
	int current_label = 0;
	if (bucket[0]->next == bucket[0]) {
		current_label = -1;
	}
	while (current_label >= 0) {
		/*
		if (counter > RATIO * (n + m)) {
			counter = 0;
			global_relabeling();
		}
		*/
		if (current_label >= n) {
			current_label = n - 1;
		}
		if (bucket[current_label]->next == bucket[current_label]) {
			current_label--;
			continue;
		}
		int current_node = bucket[current_label]->next->id;
		node[current_node]->prev->next = node[current_node]->next;
		node[current_node]->next->prev = node[current_node]->prev;
		int last_label = node[current_node]->label;
		discharge(current_node);
		if (node[current_node]->label != last_label) {
			current_label = node[current_node]->label;
			node[current_node]->prev = bucket[current_label];
			node[current_node]->next = node[current_node]->prev->next;
			node[current_node]->prev->next = node[current_node];
			node[current_node]->next->prev = node[current_node];
		}
		else if (bucket[current_label]->next == bucket[current_label]) {
			current_label--;
		}
	}
	cutset.optimal_cost = node[n - 1]->excess;
	global_relabeling();
	for (int i = 0; i < n; i++) {
		cutset.optimal.push_back(node[i]->visited);
	}
	for (int i = 0; i < n; i++) {
		for (Arc *arc = node[i]->outgoing->next_out; arc != node[i]->outgoing; arc = arc->next_out) {
			if (!arc->auxillary) {
				continue;
			}
			arc->next_in->prev_in = arc->prev_in;
			arc->prev_in->next_in = arc->next_in;
			arc->next_out->prev_out = arc->prev_out;
			arc->prev_out->next_out = arc->next_out;
		}
	}
}

int main() {
	freopen("cuts.in", "r", stdin);
	freopen("cuts.out", "w", stdout);
	scanf("%d%d", &n, &m);
	assert(n >= 2 && n <= MAXN);
	assert(m >= 0 && m <= MAXM);
	for (int i = 0; i < n; i++) {
		node[i] = new Node;
		node[i]->id = i;
		node[i]->outgoing = new Arc(-1, -1, -1, false);
		node[i]->ingoing = new Arc(-1, -1, -1, false);
	}
	for (int i = 0; i < 2 * n; i++) {
		bucket[i] = new Node;
	}
	std::set<std::pair<int, int> > was;
	for (int i = 0; i < m; i++) {
		int a, b, c;
		scanf("%d%d%d", &a, &b, &c);
		a--;
		b--;
		assert(0 <= a && a < n);
		assert(0 <= b && b < n);
		assert(!was.count(std::make_pair(a, b)));
		assert(c > 0 && c <= MAXC);
		was.insert(std::make_pair(a, b));
		add_arc(a, b, c, false);
	}
	int left;
	scanf("%d", &left);
	assert(left >= 1 && left <= MAXK);
	CutSet start(std::vector<int>(n, 2));
	start.mask[0] = 0;
	start.mask[n - 1] = 1;
	process(start);
	cutsets.push(start);
	while (!cutsets.empty()) {
		CutSet current_cutset = cutsets.top();
		cutsets.pop();
		for (int i = 0; i < n; i++) {
			printf("%d", current_cutset.optimal[i]);
		}
		printf("\n");
		//std::cout << current_cutset.optimal_cost << "\n";
		left--;
		if (!left) {
			return 0;
		}
		std::vector<int> tmp = current_cutset.mask;
		for (int i = 0; i < n; i++) {
			if (current_cutset.mask[i] != 2) {
				continue;
			}
			tmp[i] = 1 - current_cutset.optimal[i];
			CutSet next(tmp);
			process(next);
			cutsets.push(next);
			tmp[i] = 1 - tmp[i];
		}
	}
	assert(false);
	return 0;
}
