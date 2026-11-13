#include "treeunit.h"

#define MAXN 200000

int n, i, a, b, c;
int can[MAXN + 1];

int main(void) {
    init();
    n = getN();
    for (i = 1; i <= n; i++) {
        can[i] = 1;
    }
    for (i = 1; i < n; i++) {
        a = getA(i);
        b = getB(i);
        c = query(i);
        if (c) can[a] = 0;
        else can[b] = 0;
    }
    for (i = 1; i <= n; i++) {
        if (!can[i]) continue;
        report(i);
    }
    return 0;
}
