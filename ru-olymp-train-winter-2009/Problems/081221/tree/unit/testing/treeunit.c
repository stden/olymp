#include "treeunit.h"

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#define INPUT_FILE "1371283.in"
#define OUTPUT_FILE "1371283.out"
#define MAXN 200000
#define MAXD 5
#define MAXQ 100

struct Edge {
    int v, i, p, n;
};

static int initialized = 0, numQ = 0, cur_rand, answer;
static int n, ne;
static int a[MAXN + 1], b[MAXN + 1], p[MAXN + 1], deg[MAXN + 1], fe[MAXN + 1];
static int cache[MAXN + 1];
static char buf[1000];
static struct Edge ed[3 * MAXN];
static int q1[MAXN + 10], q2[MAXN + 10];
static int was[MAXN + 10];

void reportError(char *reason) {
    FILE *ouf;
    ouf = fopen(OUTPUT_FILE, "w");
    fprintf(ouf, "%s\n", reason);
    fclose(ouf);
    exit(0);
}

int get(int x) {
    if (x != p[x])
        p[x] = get(p[x]);
    return p[x];
}

void unite(int x, int y) {
    x = get(x);
    y = get(y);
    if (my_rand() % 2)
        p[x] = y;
    else
        p[y] = x;
}

int my_rand() {
    int res = cur_rand;
    if (res < 0) res *= -1;
    cur_rand *= 999983;
    cur_rand += 1000000007;
    return res;
}

void addEdge(int x, int y, int i) {
    ed[ne].v = y;
    ed[ne].i = i;
    ed[ne].p = fe[x];
    ed[ne].n = ed[fe[x]].n;
    ed[ed[ne].p].n = ne;
    ed[ed[ne].n].p = ne;
    ne++;
    ed[ne].v = x;
    ed[ne].i = i;
    ed[ne].p = fe[y];
    ed[ne].n = ed[fe[y]].n;
    ed[ed[ne].p].n = ne;
    ed[ed[ne].n].p = ne;
    ne++;
}

void init() {
    int i;
    if (initialized) {
        sprintf(buf, "already initialized");
        reportError(buf);
    }
    cur_rand = 12312736;
    initialized = 1;
    FILE *inf = fopen(INPUT_FILE, "r");
    if (!inf) {
        reportError("input file not found");
    }
    fscanf(inf, "%d", &n);
    if (n < 1 || n > MAXN) {
        sprintf(buf, "invalid n: %d", n);
        reportError(buf);
    }
    for (i = 1; i <= n; i++) {
        p[i] = i;
        deg[i] = 0;
        fe[i] = i - 1;
        ed[i].v = 0;
        ed[i].n = i;
        ed[i].p = i;
        was[i] = 0;
    }
    ne = n;
    for (i = 1; i < n; i++) {
        fscanf(inf, "%d%d", &a[i], &b[i]);
        if (a[i] < 1 || a[i] > n) {
            sprintf(buf, "invalid a[%d]: %d", i, a[i]);
            reportError(buf);
        }
        if (b[i] < 1 || b[i] > n) {
            sprintf(buf, "invalid b[%d]: %d", i, b[i]);
            reportError(buf);
        }
        if (get(a[i]) == get(b[i])) {
            sprintf(buf, "invalid graph: not a tree");
            reportError(buf);
        }
        unite(a[i], b[i]);
        deg[a[i]]++;
        deg[b[i]]++;
        addEdge(a[i], b[i], i);
    }
    for (i = 1; i <= n; i++) {
        if (deg[i] > MAXD) {
            sprintf(buf, "invalid degree of vertex %d: %d", i, deg[i]);
            reportError(buf);
        }
    }
    fclose(inf);
    for (i = 1; i < n; i++) {
        cache[i] = -1;
    }
}

int getN(void) {
    if (!initialized) {
       reportError("not initialized");
    }
    return n;
}

int getA(int edgeNum) {
    if (!initialized) {
        reportError("not initialized");
    }
    if (edgeNum < 1 || edgeNum >= n) {
        sprintf(buf, "invalid call: getA(%d)", edgeNum);
        reportError(buf);
    }
    return a[edgeNum];
}

int getB(int edgeNum) {
    if (!initialized) {
        reportError("not initialized");
    }
    if (edgeNum < 1 || edgeNum >= n) {
        sprintf(buf, "invalid call: getB(%d)", edgeNum);
        reportError(buf);
    }
    return b[edgeNum];
}

void erase(int x, int y) {
    int i;
    for (i = ed[fe[x]].n; i != fe[x]; i = ed[i].n) {
        if (ed[i].v == y) {
            ed[ed[i].n].p = ed[i].p;
            ed[ed[i].p].n = ed[i].n;
            return;
        }
    }
    assert(0);
}

void mark(int en, int p, int q) {
    if (a[en] == p && b[en] == q) {
        cache[en] = 0;
    }
    else {
        cache[en] = 1;
        assert(a[en] == q);
        assert(b[en] == p);
    }
}

int query(int edgeNum) {
    int l1, r1, l2, r2, v1, v2, i;
    if (!initialized) {
        reportError("not initialized");
    }
    if (edgeNum < 1 || edgeNum >= n) {
        sprintf(buf, "invalid call: query(%d)", edgeNum);
        reportError(buf);
    }
    numQ++;
    if (numQ > MAXQ) {
        sprintf(buf, "too many queries: %d", numQ);
        reportError(buf);
    }
    if (cache[edgeNum] != -1) {
        return cache[edgeNum];
    }
    erase(a[edgeNum], b[edgeNum]);
    erase(b[edgeNum], a[edgeNum]);
    l1 = 0;
    r1 = 0;
    l2 = 0;
    r2 = 0;
    was[a[edgeNum]] = edgeNum;
    was[b[edgeNum]] = edgeNum;
    q1[0] = a[edgeNum];
    q2[0] = b[edgeNum];
    while (l1 <= r1 && l2 <= r2) {
        v1 = q1[l1++];
        v2 = q2[l2++];
        for (i = ed[fe[v1]].n; i != fe[v1]; i = ed[i].n) {
            if (was[ed[i].v] != edgeNum) {
                was[ed[i].v] = edgeNum;
                q1[++r1] = ed[i].v;
            }
        }
        for (i = ed[fe[v2]].n; i != fe[v2]; i = ed[i].n) {
            if (was[ed[i].v] != edgeNum) {
                was[ed[i].v] = edgeNum;
                q2[++r2] = ed[i].v;
            }
        }
    }
    if (l1 > r1) {
        answer = b[edgeNum];
        cache[edgeNum] = 1;
        l1 = 0;
        r1 = 0;
        q1[0] = a[edgeNum];
        was[a[edgeNum]] = -edgeNum;
    }
    else {
        answer = a[edgeNum];
        cache[edgeNum] = 0;
        l1 = 0;
        r1 = 0;
        q1[0] = b[edgeNum];
        was[b[edgeNum]] = -edgeNum;
    }
    while (l1 <= r1) {
        v1 = q1[l1++];
        for (i = ed[fe[v1]].n; i != fe[v1]; i = ed[i].n) {
            if (was[ed[i].v] != -edgeNum) {
                mark(ed[i].i, v1, ed[i].v);
                was[ed[i].v] = -edgeNum;
                q1[++r1] = ed[i].v;
            }
        }
    }
    return cache[edgeNum];
}

void report(int vertexNum) {
    int i;
    if (!initialized) {
        reportError("not initialized");
    }
    if (vertexNum < 1 || vertexNum > n) {
        sprintf(buf, "invalid call: report(%d)", vertexNum);
        reportError(buf);
    }
    for (i = 1; i < n; i++) {
        if (cache[i] == -1) {
            reportError("ambiguous answer");
        }
    }
    if (vertexNum != answer) {
        sprintf(buf, "wa: %d expected, but %d found", answer, vertexNum);
        reportError(buf);
    }
    sprintf(buf, "ok: %d queries", numQ);
    reportError(buf);
}
