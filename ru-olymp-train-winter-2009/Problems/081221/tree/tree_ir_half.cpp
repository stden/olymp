#include "treeunit.h"
#include <algorithm>
#include <cassert>
#include <cstdio>
#include <vector>

using namespace std;

template<typename T> T abs(T x) {
    if (x < 0) return -x;
    return x;
}

#define MAXN 200000

int n;
int a[MAXN], b[MAXN], am[MAXN];
vector<int> e[MAXN];
int depth[MAXN];
vector<bool> left;

void dfs(int x, int p, int d) {
    am[x] = 1;
    depth[x] = d;
    for (int i = 0; i < int(e[x].size()); i++) {
        if (e[x][i] != p) {
            dfs(e[x][i], x, d + 1);
            am[x] += am[e[x][i]];
        }
    }
}

void dfs1(int x, int p) {
    left[x] = false;    
    for (int i = 0; i < int(e[x].size()); i++) {
        if (e[x][i] != p) {
            dfs1(e[x][i], x);
        }
    }
}

int main() {
    init();
    n = getN();
    for (int i = 0; i < n - 1; i++) {
        a[i] = getA(i + 1) - 1;
        b[i] = getB(i + 1) - 1;
    }
    left.resize(n);
    for (int i = 0; i < n; i++) {
        left[i] = true;
    }
    for (;;) {
        int root = -1, num = 0;
        for (int i = 0; i < n; i++) {
            if (left[i]) {
                root = i;
                num++;
            }
        }
        assert(root != -1);
        if (num == 1) {
            report(root + 1);
        }
        for (int i = 0; i < n; i++) {
            e[i].clear();
        }
        for (int i = 0; i < n - 1; i++) {
            if (left[a[i]] && left[b[i]]) {
                e[a[i]].push_back(b[i]);
                e[b[i]].push_back(a[i]);
            }
        }
        dfs(root, -1, 0);
        int best = 123456789, who = -1;
        for (int i = 0; i < n - 1; i++) {
            if (!left[a[i]] || !left[b[i]]) continue;
            int cur = 123456789;
            if (depth[a[i]] < depth[b[i]]) {
                cur = abs(am[b[i]] - num + am[b[i]]);
            }
            else {
                cur = abs(am[a[i]] - num + am[a[i]]);
            }
            if (cur < best) {
                best = cur;
                who = i;
            }
        }
        assert(who != -1);
        vector<int>::iterator it1 = find(e[a[who]].begin(), e[a[who]].end(), b[who]);
        e[a[who]].erase(it1);
        vector<int>::iterator it2 = find(e[b[who]].begin(), e[b[who]].end(), a[who]);
        e[b[who]].erase(it2);
        int tmp = query(who + 1);
        if (!tmp) {
            dfs1(b[who], -1);
        }
        else {
            dfs1(a[who], -1);
        }
    }
    return 0;
}
