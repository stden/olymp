#include <algorithm>
#include <cassert>
#include <cstdio>
#include <cstring>

using namespace std;

#define MAXN 200000
#define MAXM 200000
#define MAXC 1000000

int n, m;
int a[MAXN + MAXM];

int main() {
    freopen("dynarray.in", "r", stdin);
    freopen("dynarray.out", "w", stdout);
    scanf("%d%d", &n, &m);
    assert(n >= 1);
    assert(n <= MAXN);
    assert(m >= 1);
    assert(m <= MAXM);
    for (int i = 0; i < n; i++) {
        scanf("%d", &a[i]);
        assert(a[i] >= 0);
        assert(a[i] <= MAXC);
    }
    for (int i = 0; i < m; i++) {
        int cmd;
        scanf("%d", &cmd);
        if (cmd == 1) {
            int x, y;
            scanf("%d%d", &x, &y);
            assert(x >= 1);
            assert(x <= n);
            assert(y >= 0);
            assert(y <= MAXC);
            a[x - 1] = y;
        }
        else if (cmd == 2) {
            int x, y;
            scanf("%d%d", &x, &y);
            assert(x >= 0);
            assert(x <= n);
            assert(y >= 0);
            assert(y <= MAXC);
            memmove(&a[x + 1], &a[x], sizeof(int) * (n - x));
            n++;
            a[x] = y;
        }
        else {
            assert(cmd == 3);
            int x, y, z;
            scanf("%d%d%d", &x, &y, &z);
            assert(x >= 1);
            assert(x <= y);
            assert(y <= n);
            assert(z >= 0);
            assert(z <= MAXC);
            int res = 0;
            for (int i = x - 1; i <= y - 1; i++) {
                if (a[i] <= z) {
                    res++;
                }
            }
            printf("%d\n", res);
        }
    }
    return 0;
}
