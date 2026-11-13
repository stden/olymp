#include <algorithm>
#include <cassert>
#include <cstdio>
#include <iostream>
#include <cstring>
#include <queue>
#include <vector>

using namespace std;

#define MAXN 100
#define MAXC 1000000000
#define INF 1000000000000000ll

typedef long long ll;
typedef ll Matr[MAXN][MAXN];

struct Entry {
    vector<int> location;
    vector<int> exact;
    ll cost;

    Entry(const vector<int> &location): location(location) {}
};

bool operator < (const Entry &a, const Entry &b) {
    return a.cost > b.cost;
}

struct Edge {
    int a, b, c;
    Edge(int a, int b, int c): a(a), b(b), c(c) {}
};

int n, m;
Matr c0, c1, fl;
vector<Entry> entries;
ll cur_cap;
bool was[MAXN];
priority_queue<Entry> q;
vector<Edge> edges;
vector<int> nb[MAXN];

bool dfs(int x) {
    if (was[x]) return false;
    was[x] = true;
    if (x == n - 1) return true;
    for (int j = 0; j < int(nb[x].size()); j++) {
        int i = nb[x][j];
        if (fl[x][i] + cur_cap <= c1[x][i] && dfs(i)) {
            fl[x][i] += cur_cap;
            fl[i][x] -= cur_cap;
            return true;
        }
    }
    return false;
}

void calc(Entry &entry) {
    assert(entry.location[0] == 0);
    assert(entry.location[n - 1] == 1);
    for (int i = 0; i < n; i++) {
        assert(entry.location[i] >= 0);
        assert(entry.location[i] <= 2);
    }
    memset(c1, 0, sizeof(c1));
    for (int i = 0; i < n; i++) {
        nb[i].clear();
    }
    for (int i = 0; i < int(edges.size()); i++) {
        c1[edges[i].a][edges[i].b] = edges[i].c;
        nb[edges[i].a].push_back(edges[i].b);
        nb[edges[i].b].push_back(edges[i].a);
    }
    for (int i = 1; i < n - 1; i++) {
        if (entry.location[i] == 0) {
            c1[0][i] = INF;
            nb[0].push_back(i);
            nb[i].push_back(0);
        }
        else if (entry.location[i] == 1) {
            c1[i][n - 1] = INF;
            nb[i].push_back(n - 1);
            nb[n - 1].push_back(i);
        }
    }
    for (int i = 0; i < n; i++) {
        sort(nb[i].begin(), nb[i].end());
        nb[i].erase(unique(nb[i].begin(), nb[i].end()), nb[i].end());
    }
    memset(fl, 0, sizeof(fl));
    cur_cap = INF;
    entry.cost = 0;
    while (cur_cap) {
        memset(was, 0, sizeof(was));
        if (dfs(0)) {
            entry.cost += cur_cap;
        }
        else {
            cur_cap /= 2;
        }
    }
    entry.exact.clear();
    for (int i = 0; i < n; i++) {
        if (was[i]) {
            entry.exact.push_back(0);
        }
        else {
            entry.exact.push_back(1);
        }
    }
}

int main() {
    freopen("cuts.in", "r", stdin);
    freopen("cuts.out", "w", stdout);
    scanf("%d%d", &n, &m);
    assert(n >= 2);
    assert(n <= MAXN);
    assert(m >= 0);
    for (int i = 0; i < m; i++) {
        int a, b, c;
        scanf("%d%d%d", &a, &b, &c);
        assert(a >= 1);
        assert(a <= n);
        assert(b >= 1);
        assert(b <= n);
        assert(a != b);
        assert(c >= 1);
        assert(c <= MAXC);
        a--;
        b--;
        assert(!c0[a][b]);
        c0[a][b] = c;
        edges.push_back(Edge(a, b, c));
    }
    int left;
    scanf("%d", &left);
    assert(left > 0);
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
        //cout << cur.cost << "\n";
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
