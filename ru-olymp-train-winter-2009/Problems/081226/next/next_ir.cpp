#include <cassert>
#include <cstdio>
#include <cstring>

#define MAXN 10000

char buf[MAXN + 10];

int main() {
    freopen("next.in", "r", stdin);
    freopen("next.out", "w", stdout);
    gets(buf);
    int n = strlen(buf);
    assert(n >= 2 && n <= MAXN);
    for (int i = 0; i < n; i++) assert(buf[i] == '0' || buf[i] == '1');
    for (int i = 1; i < n; i++) {
        int j = 0;
        while (buf[j] == buf[i + j]) j++;
        assert(buf[j] < buf[i + j]);
    }
    int m = n;
    int niter = 0;
    for (;;) {
        niter++;
        if (m == 1) assert(false);
        for (int i = m; i < n; i++) buf[i] = buf[i % m];
        m = n;
        while (buf[m - 1] == '1') m--;
        buf[m - 1] = '1';
        if (m == n) break;
    }
    for (int i = 0; i < n; i++) printf("%c", buf[i]);
    printf("\n");
    fprintf(stderr, "%d\n", niter);
    return 0;
}
