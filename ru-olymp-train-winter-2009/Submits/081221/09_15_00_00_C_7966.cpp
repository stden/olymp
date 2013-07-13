#include "treeunit.h"
#include <algorithm>
#include <cstdio>
#include <vector>

using namespace std;

#define MAXN 200000

int n;
int a[MAXN], b[MAXN], am[MAXN], de[MAXN];
vector<int> e[MAXN];

void dfs(int x, int p, int d) {
    de[x] = d;
    am[x] = 1;
    for (int i = 0; i < int(e[x].size()); i++) {
        if (e[x][i] == p) continue;
        dfs(e[x][i], x, d + 1);
        am[x] += am[e[x][i]];
    }
}

void dfs1(int x, int p, vector<bool> &was) {
    was[x] = true;
    for (int i = 0; i < int(e[x].size()); i++) {
        if (e[x][i] == p) continue;
        dfs1(e[x][i], x, was);
    }
}

int get(int p, int q, int num) {
    if (de[p] < de[q]) return am[q];
    return num - am[p];
}

void solve(vector<bool> &left) {
    int num = 0;
    int root = -1;
    for (int i = 0; i < n; i++) {
        e[i].clear();
        if (left[i]) root = i, num++;
    }
    if (num == 1) {
        report(root);
    }
    for (int i = 0; i < n - 1; i++) {
        if (left[a[i]] && left[b[i]]) {
            e[a[i]].push_back(b[i]);
            e[b[i]].push_back(a[i]);
        }
    }
    dfs(root, -1, 0);
    int cur = root;
    for (;;) {
        bool ok = true;
        for (int i = 0; i < int(e[cur].size()); i++) {
            if (get(cur, e[cur][i], num) > num / 2) {
                cur = e[cur][i];
                ok = false;
                break;
            }
        }
        if (ok) break;
    }
    int p = -1, q = -1;
    for (int i = 0; i < n - 1; i++) {
        if (left[a[i]] && left[b[i]] && (a[i] == cur || b[i] == cur)) {
            int tmp = query(i + 1);
            if ((a[i] == cur && tmp == 1) || (b[i] == cur && tmp == 0)) {
                p = cur;
                q = a[i] + b[i] - cur;
                break;
            }
        }
    }
    if (p == -1) report(cur + 1);
    for (int i = 0; i < int(e[q].size()); i++) {
        if (e[q][i] == p) {
            e[q].erase(e[q].begin() + i);
            break;
        }
    }
    fill(left.begin(), left.end(), false);
    dfs1(q, -1, left);
    solve(left);
}

int main() {
    init();
    n = getN();
    for (int i = 0; i < n - 1; i++) {
        a[i] = getA(i + 1) - 1;
        b[i] = getB(i + 1) - 1;
    }
    vector<bool> tmp(n, true);
    solve(tmp);
    return 0;
}
