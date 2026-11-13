#include <cmath>
#include <cstdio>
#include <cstdlib>
#include "random.h"

#define PI 3.14159265358979323

template<typename T> T abs(T x) {
    return (x > 0)? x : -x;
}

double normal() {
    double u = rndvalue();
    double v = rndvalue();
    return sqrt(-2.0 * log(u)) * cos(2 * PI * v);
}

int main(int argc, char **argv) {
    int seed = atoi(argv[1]);
    initrand(seed);
    int n = atoi(argv[2]);
    int m = atoi(argv[3]);
    int p = atoi(argv[4]);
    int q = atoi(argv[5]);
    printf("%d %d\n", n, m);
    for (int i = 0; i < n; i++) {
        printf("%d ", R(0, 1000000));
    }
    printf("\n");
    int csz = n;
    for (int i = 0; i < m; i++) {
        int we = R(1, 100);
        if (we <= p) {
            printf("1 %d %d\n", R(1, csz), R(0, 1000000));
        }
        else if (we <= p + q) {
            printf("2 %d %d\n", R(0, csz), R(0, 1000000));
            csz++;
        }
        else {
            int u, v;
            do {
                u = int(normal() * csz / 10.0);
                v = int(csz + normal() * csz / 10.0);
            } while (u < 1 || v > csz || u > v);
            printf("3 %d %d %d\n", u, v, R(0, 1000000));
        }
    }
    return 0;
}
