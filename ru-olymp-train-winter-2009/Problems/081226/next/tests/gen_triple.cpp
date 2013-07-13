#include "random.h"

#include <cassert>
#include <cstdio>
#include <cstdlib>

int main(int argc, char **argv) {
    assert(argc == 3);
    int seed = atoi(argv[1]);
    initrand(seed);
    int n = atoi(argv[2]);
    int u, v, w = 0;
    for (;;) {
        u = R(1, n - 1);
        v = R(1, n - 1);
        if (u >= v) continue;
        if (u - 1 >= v - u - 1) continue;
        if (v - u - 1 >= n - v - 1) continue;
        break;
    }
    for (int i = 0; i < n; i++) {
        if (i == u || i == v || i == w) {
            printf("0");
        }
        else printf("1");
    }
    printf("\n");
    return 0;
}
