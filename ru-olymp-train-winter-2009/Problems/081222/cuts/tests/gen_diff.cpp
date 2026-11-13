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
    if (argc != 6) {
        printf("usage: <seed> <w> <h> <m> <k>\n");
        return 0;
    }
    int seed = atoi(argv[1]);
    int w = atoi(argv[2]);
    int h = atoi(argv[3]);
    int m = atoi(argv[4]);
    int k = atoi(argv[5]);
    initrand(seed);
    //0 1..h h+1..2h .. h*(w-1)+1..h*w h*w+1
    printf("%d %d\n", h * w + 2, (w + 1) * h + m);
    for (int i = 1; i <= h; i++) {
        e.push_back(Edge(0, i, R(1, 5)));
        e.push_back(Edge((w - 1) * h + i, w * h + 1, R(1, 5)));
    }
    for (int i = 1; i < w; i++) {
        for (int j = 1; j <= h; j++) {
            e.push_back(Edge((i - 1) * h + j, i * h + j, R(1, 5)));
        }
    }
    memset(was, 0, sizeof(was));
    for (int i = 0; i < int(e.size()); i++) {
        was[e[i].a][e[i].b] = true;
    }
    for (int i = 0; i < m; i++) {
        int u, v, ww;
        do {
            u = R(0, w * h + 1);
            v = R(0, w * h + 1);
            ww = R(1, 1000);
        } while (u == v || was[u][v]);
        was[u][v] = true;
        e.push_back(Edge(u, v, ww));
    }
    shuffle(1, w * h + 1);
    for (int i = 0; i < int(e.size()); i++) {
        printf("%d %d %d\n", e[i].a + 1, e[i].b + 1, e[i].c);
    }
    printf("%d\n", k);
    return 0;
}
