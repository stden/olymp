#include "treeunit.h"

#include <stdio.h>
#include <stdlib.h>

#define INPUT_FILE "input.txt"
#define MAXN 200000
#define MAXD 5
#define MAXQ 100

struct Edge {
    int v, n;
};

static int initialized = 0, numQ = 0;
static int n, ne, secret;
static int a[MAXN + 1], b[MAXN + 1], p[MAXN + 1], f[MAXN + 1], deg[MAXN + 1], depth[MAXN + 1];
static char buf[1000];
static struct Edge e[2 * MAXN + 1];

void reportError(char *reason) {
    printf("%s\n", reason);
    exit(0);
}

int get(int x) {
    if (x != p[x]) p[x] = get(p[x]);
    return p[x];
}

void unite(int x, int y) {
    x = get(x), y = get(y);
    if (rand() % 2) p[x] = y;
    else p[y] = x;
}

void addEdge(int x, int y) {
    ne++;
    e[ne].v = y;
    e[ne].n = f[x];
    f[x] = ne;    
    ne++;
    e[ne].v = x;
    e[ne].n = f[y];
    f[y] = ne;
}

void dfs(int x, int p, int d) {
    int cur;
    depth[x] = d;
    for (cur = f[x]; cur; cur = e[cur].n) {
        if (e[cur].v == p) {
            continue;
        }
        dfs(e[cur].v, x, d + 1);
    }
}

void init() {
    int i;
    printf("init()\n");
    if (initialized) {
        sprintf(buf, "already initialized");
        reportError(buf);
    }
    srand(0xdead);
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
        f[i] = 0;
        deg[i] = 0;
    }
    ne = 0;
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
        addEdge(a[i], b[i]);
        deg[a[i]]++;
        deg[b[i]]++;
    }
    for (i = 1; i <= n; i++) {
        if (deg[i] > MAXD) {
            sprintf(buf, "invalid degree of vertex %d: %d", i, deg[i]);
            reportError(buf);
        }
    }
    fscanf(inf, "%d", &secret);
    if (secret < 1 || secret > n) {
        sprintf(buf, "invalid secret: %d", secret);
        reportError(buf);
    }
    fclose(inf);
    dfs(secret, 0, 0);
}

int getN(void) {
    printf("getN()\n");
    if (!initialized) {
       reportError("not initialized");
    }
    return n;
}

int getA(int edgeNum) {
    printf("getA(%d)\n", edgeNum);
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
    printf("getB(%d)\n", edgeNum);
    if (!initialized) {
        reportError("not initialized");
    }
    if (edgeNum < 1 || edgeNum >= n) {
        sprintf(buf, "invalid call: getB(%d)", edgeNum);
        reportError(buf);
    }
    return b[edgeNum];
}

int query(int edgeNum) {
    int i;
    printf("query(%d)\n", edgeNum);
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
    return depth[a[edgeNum]] > depth[b[edgeNum]];
}

void report(int vertexNum) {
    printf("report(%d)\n", vertexNum);
    if (!initialized) {
        reportError("not initialized");
    }
    if (vertexNum < 1 || vertexNum > n) {
        sprintf(buf, "invalid call: report(%d)", vertexNum);
        reportError(buf);
    }
    if (vertexNum == secret) {
        printf("ok: %d queries\n", numQ);
    }
    else {
        printf("wa: %d expected but %d found\n", secret, vertexNum);
    }
    exit(0);
}
