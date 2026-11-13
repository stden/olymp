#include "random.h"
#include <algorithm>
#include <cassert>
#include <cstdio>
#include <cstdlib>

using namespace std;

#define MAXN 20000

char buf[MAXN];

int main(int argc, char **argv) {
    assert(argc == 3);
    int seed = atoi(argv[1]);
    int n = atoi(argv[2]);
    initrand(seed);
    buf[0] = '0';
    int len = 1;
    while (len < n) {
        int u = min(5, n - len);
        u = R(1, u);
        for (int i = 0; i < u; i++) {
            buf[len + i] = buf[i];
        }
        len += u;
        while (buf[len - 1] == '1') len--;
        buf[len - 1] = '1';
    }
    buf[len] = '\0';
    printf("%s\n", buf);
    return 0;
}
