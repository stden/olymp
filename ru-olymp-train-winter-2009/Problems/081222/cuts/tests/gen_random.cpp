#include "random.h"

#include <cstdio>
#include <cstring>
#include <vector>

using namespace std;

struct Edge {
    int a, b, c;

    Edge(int a, int b, int c): a(a), b(b), c(c) {}
};

vector<Edge> e;
bool was[200][200];

void shuffle(int l, int r) {
    for (int i = 0; i < int(e.size()); i++) {
        int j = R(0, i);
        swap(e[i], e[j]);
    }
    int we[1000];
    for (int i = l; i <= r; i++) {
        we[i] = i;
        int j = R(l, i);
        swap(we[j], we[i]);
    }
    for (int i = 0; i < int(e.size()); i++) {
        if (e[i].a >= l && e[i].a <= r) {
            e[i].a = we[e[i].a];
        }
        if (e[i].b >= l && e[i].b <= r) {
            e[i].b = we[e[i].b];
        }
    }
}

int main(int argc, char **argv) {
    if (argc != 5) {
        printf("usage: <seed> <n> <m> <k>\n");
        return 0;
    }
    int seed = atoi(argv[1]);
    int n = atoi(argv[2]);
    int m = atoi(argv[3]);
    int k = atoi(argv[4]);
    initrand(seed);
    memset(was, 0, sizeof(was));
    for (int i = 0; i < m; i++) {
        int u, v, ww;
        do {
            u = R(0, n - 1);
            v = R(0, n - 1);
            ww = R(1, 1000000000);
        } while (u == v || was[u][v]);
        was[u][v] = true;
        e.push_back(Edge(u, v, ww));
    }
    shuffle(1, n - 1);
    printf("%d %d\n", n, m);
    for (int i = 0; i < int(e.size()); i++) {
        printf("%d %d %d\n", e[i].a + 1, e[i].b + 1, e[i].c);
    }
    printf("%d\n", k);
    return 0;
}
