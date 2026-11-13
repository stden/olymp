#include <cassert>
#include <cstdio>
#include <cstring>

#define MAXN 10000

char buf[MAXN + 10];
char last[MAXN + 10];

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
    int best = 0;
    for (int i = 0; i < n; i++) {
        last[i] = buf[i];
    }
    last[n] = '\0';
    for (;;) {
        niter++;
        if (m == 1) break;
        for (int i = m; i < n; i++) buf[i] = buf[i % m];
        m = n;
        while (buf[m - 1] == '1') m--;
        buf[m - 1] = '1';
        if (m == n) {
            if (niter > 4) {
                printf("%s\n%s\n", last, buf);
                printf("%d\n", best);
            }
            if (niter > best) {
                best = niter;
//                printf("%s\n%s\n", last, buf);
//                printf("%d\n", best);
            }
            niter = 0;
            for (int i = 0; i < n; i++) {
                last[i] = buf[i];
            }
        }
    }
    return 0;
}
