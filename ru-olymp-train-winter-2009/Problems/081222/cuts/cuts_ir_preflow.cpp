#define _CRT_SECURE_NO_DEPRECATE

#include <algorithm>
#include <cassert>
#include <cstdio>
#include <cstring>
#include <queue>
#include <set>
#include <vector>

using namespace std;

#define MAXN 100
#define MAXM 1000
#define INF 1000000000000000ll

typedef long long ll;

struct Arc {
	int tail;
	int head;
	ll capacity;
	ll flow;
	Arc *reverse;
	Arc *next_arc;
	bool fake;
};

struct Entry {
	vector<int> location;
	vector<int> exact;
	ll cost;

	Entry(const vector<int> &location): location(location) {}
};

struct Node {
	int data;
	Node *next;
	Node *prev;
};

bool operator < (const Entry &a, const Entry &b) {
    return a.cost > b.cost;
}

int n, m;
Arc *first_arc[MAXN];
Arc *cur_arc[MAXN];
Arc arcs[3 * MAXM + 3 * MAXN];
int label[MAXN];
ll excess[MAXN];
set<int> buckets[2 * MAXN];
bool was[MAXN];
priority_queue<Entry> q;

void push(Arc *arc) {
	ll u = min(excess[arc->tail], arc->capacity - arc->flow);
	assert(u > 0);
	arc->flow += u;
	arc->reverse->flow -= u;
	excess[arc->tail] -= u;
	excess[arc->head] += u;
	if (excess[arc->head] == u && arc->head && arc->head != n - 1) {
		buckets[label[arc->head]].insert(arc->head);
	}
}

void relabel(int x) {
	label[x] = 123456789;
	for (Arc *arc = first_arc[x]; arc; arc = arc->next_arc) {
		if (arc->flow < arc->capacity && label[arc->head] + 1 < label[x]) {
			label[x] = label[arc->head] + 1;
		}
	}
}

void discharge(int x) {
	bool time_to_relabel = false;
	do {
		if (cur_arc[x]->flow < cur_arc[x]->capacity && label[x] == label[cur_arc[x]->head] + 1) {
			push(cur_arc[x]);
		}
		else {
			if (cur_arc[x]->next_arc) {
				cur_arc[x] = cur_arc[x]->next_arc;
			}
			else {
				cur_arc[x] = first_arc[x];
				time_to_relabel = true;
			}
		}
	} while (excess[x] != 0 && !time_to_relabel);
	if (time_to_relabel) {
		relabel(x);
	}
}

void dfs(int x) {
    was[x] = true;
    for (Arc *arc = first_arc[x]; arc; arc = arc->next_arc) {
        if (arc->flow == arc->capacity) continue;
        if (was[arc->head]) continue;
        dfs(arc->head);
    }
}

void calc(Entry &entry) {
	// add new arcs
	int narcs = 2 * m;
	for (int i = 1; i < n - 1; i++) {        
		if (entry.location[i] == 0) {
			arcs[narcs].tail = 0;
			arcs[narcs].head = i;
			arcs[narcs].capacity = INF;
			arcs[narcs].reverse = &arcs[narcs + 1];
			arcs[narcs].next_arc = first_arc[0];
			first_arc[0] = &arcs[narcs];
			arcs[narcs].fake = true;
			narcs++;
			arcs[narcs].tail = i;
			arcs[narcs].head = 0;
			arcs[narcs].capacity = 0;
			arcs[narcs].reverse = &arcs[narcs - 1];
			arcs[narcs].next_arc = first_arc[i];
			first_arc[i] = &arcs[narcs];
			arcs[narcs].fake = true;
			narcs++;
		}
		else if (entry.location[i] == 1) {
			arcs[narcs].tail = i;
			arcs[narcs].head = n - 1;
			arcs[narcs].capacity = INF;
			arcs[narcs].reverse = &arcs[narcs + 1];
			arcs[narcs].next_arc = first_arc[i];
			first_arc[i] = &arcs[narcs];
			arcs[narcs].fake = true;
			narcs++;
			arcs[narcs].tail = n - 1;
			arcs[narcs].head = i;
			arcs[narcs].capacity = 0;
			arcs[narcs].reverse = &arcs[narcs - 1];
			arcs[narcs].next_arc = first_arc[n - 1];
			first_arc[n - 1] = &arcs[narcs];
			arcs[narcs].fake = true;
			narcs++;
		}
	}
	// ------------
	/*
	for (int i = 0; i < n; i++) {
		fprintf(stderr, "%d: ", i);
		for (Arc *cur = first_arc[i]; cur; cur = cur->next_arc) {
			fprintf(stderr, "(%d, %I64d) ", cur->head, int(cur->capacity));
		}
		fprintf(stderr, "\n");
	}
	*/
	for (int i = 0; i < n; i++) {
		for (Arc *cur = first_arc[i]; cur; cur = cur->next_arc) {
			cur->flow = 0;
		}
	}
	memset(label, 0, sizeof(label));
	memset(excess, 0, sizeof(excess));
	label[0] = n;
	for (Arc *cur = first_arc[0]; cur; cur = cur->next_arc) {
		cur->flow = cur->capacity;
		cur->reverse->flow = -cur->flow;
		excess[cur->head] += cur->flow;
	}
	for (int i = 0; i < n; i++) {
		cur_arc[i] = first_arc[i];
	}
	for (int i = 0; i < 2 * n; i++) {
		buckets[i].clear();
	}
	for (int i = 1; i < n - 1; i++) {
		if (excess[i]) buckets[0].insert(i);
	}
	int p;
	if (buckets[0].size()) p = 0;
	else p = -1;
	while (p >= 0) {
		if (!buckets[p].size()) {
			p--;
			continue;
		}
		int v = *buckets[p].begin();
		buckets[p].erase(v);
		int last_label = label[v];
		discharge(v);
		if (label[v] != last_label) {
			assert(label[v] < 2 * n);
			p = label[v];
			buckets[p].insert(v);
		}
		else if (buckets[p].empty()) p--;
	}
	entry.cost = excess[n - 1];
	memset(was, 0, sizeof(was));
	dfs(0);
	entry.exact.clear();
	for (int i = 0; i < n; i++) {
	    if (was[i]) entry.exact.push_back(0);
	    else entry.exact.push_back(1);
	}
	// del new arcs
	for (int i = 0; i < n; i++) {
		while (first_arc[i] && first_arc[i]->fake) {
			first_arc[i] = first_arc[i]->next_arc;
		}
	}
	// ------------
}

int main() {
	freopen("cuts.in", "r", stdin);
	freopen("cuts.out", "w", stdout);
	scanf("%d%d", &n, &m);
	memset(first_arc, 0, sizeof(first_arc));
	for (int i = 0; i < m; i++) {
		int a, b, c;
		scanf("%d%d%d", &a, &b, &c);
		a--, b--;
		arcs[2 * i].tail = a;
		arcs[2 * i].head = b;
		arcs[2 * i].capacity = c;
		arcs[2 * i].reverse = &arcs[2 * i + 1];
		arcs[2 * i].next_arc = first_arc[a];
		first_arc[a] = &arcs[2 * i];
		arcs[2 * i].fake = false;
		arcs[2 * i + 1].tail = b;
		arcs[2 * i + 1].head = a;
		arcs[2 * i + 1].capacity = 0;
		arcs[2 * i + 1].reverse = &arcs[2 * i];
		arcs[2 * i + 1].next_arc = first_arc[b];
		first_arc[b] = &arcs[2 * i + 1];
		arcs[2 * i + 1].fake = false;
	}
	int left;
	scanf("%d", &left);
	Entry temp(vector<int>(n, 2));
	temp.location[0] = 0;
	temp.location[n - 1] = 1;
	calc(temp);
    q.push(temp);
    while (!q.empty()) {
        Entry cur = q.top();
        q.pop();
        for (int i = 0; i < n; i++) {
            printf("%d", cur.exact[i]);
        }
        printf("\n");
        left--;
        if (!left) {
            return 0;
        }
        vector<int> we = cur.location;
        for (int i = 0; i < n; i++) {
            if (cur.location[i] == 2) {
                we[i] = 1 - cur.exact[i];
                Entry en(we);
                calc(en);
                q.push(en);
                we[i] = cur.exact[i];
            }
        }
    }
    assert(false);
	return 0;
}
