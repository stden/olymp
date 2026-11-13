#include <cassert>
#include <cstdio>
#include <cstring>

#define MAXN 30

int n;
int mask, last;
bool first;
int tmp = 0;
bool g[MAXN][MAXN];
int pscore1[MAXN][1 << 10];
int pscore2[MAXN][1 << 10];
int pscore3[MAXN][1 << 10];
int score1[MAXN][1 << 10];
int score2[MAXN][1 << 10];
int score3[MAXN][1 << 10];
int cur_value, best_value;
int opt;

inline int get_cut(int x, int mask) {
    int res = 0;
    res += score1[x][mask & 1023];
    mask >>= 10;
    res += score2[x][mask & 1023];
    mask >>= 10;
    res += score3[x][mask & 1023];
    return res;
}

void gen(int cur, int k, bool rev) {
    if (cur == n) {
        int u = last & mask;
        int drop = __builtin_ctz(last ^ u);
        int gain = __builtin_ctz(mask ^ u);
        cur_value += get_cut(drop, mask);
        cur_value -= get_cut(gain, last);
        last = mask;
        if (cur_value < best_value) {
            best_value = cur_value;
            opt = mask;
        }
        return;
    }
    if (rev && k) {
        mask |= 1 << cur;
        gen(cur + 1, k - 1, !rev);
    }
    if (n - cur - 1 >= k) {
        mask &= ~(1 << cur);
        gen(cur + 1, k, rev);
    }
    if (!rev && k) {
        mask |= 1 << cur;
        gen(cur + 1, k - 1, !rev);
    }
}

int main() {
    freopen("half.in", "r", stdin);
    freopen("half.out", "w", stdout);
    int m;
    scanf("%d%d", &n, &m);
    assert(n >= 2);
    assert(n <= MAXN);
    assert(n % 2 == 0);
    for (int i = 0; i < m; i++) {
        int a, b;
        scanf("%d%d", &a, &b);
        assert(a >= 1);
        assert(a <= n);
        assert(b >= 1);
        assert(b <= n);
        assert(a != b);
        a--, b--;
        assert(!g[a][b]);
        g[a][b] = g[b][a] = true;
    }
    memset(pscore1, 0, sizeof(pscore1));
    memset(pscore2, 0, sizeof(pscore2));
    memset(pscore3, 0, sizeof(pscore3));
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < 1024; j++) {
            for (int k = 0; k < 10; k++) {
                if (((j >> k) & 1) == 0) {
                    continue;
                }
                if (k < n && g[i][k]) {
                    pscore1[i][j]++;
                }
                if (k + 10 < n && g[i][k + 10]) {
                    pscore2[i][j]++;
                }
                if (k + 20 < n && g[i][k + 20]) {
                    pscore3[i][j]++;
                }
            }
        }
    }
    for (int i = 0; i < n; i++)
     for (int j = 0; j < 1024; j++)
     {
      score1[i][j] = pscore1[i][j] - pscore1[i][1023 - j];
      score2[i][j] = pscore2[i][j] - pscore2[i][1023 - j];
      score3[i][j] = pscore3[i][j] - pscore3[i][1023 - j];
     }
    bool take[MAXN];
    memset(take, 0, sizeof(take));
    take[0] = take[1] = true;
    for (int i = 0; i < n / 2 - 2; i++) {
        take[n - i - 1] = true;
    }
    cur_value = 0;
    for (int i = 0; i < n; i++) {
        if (!take[i]) {
            continue;
        }
        for (int j = 0; j < n; j++) {
            if (take[j]) {
                continue;
            }
            if (g[i][j]) cur_value++;
        }
    }
    best_value = cur_value;
    last = 0;
    for (int i = 0; i < n; i++) {
        if (!take[i]) {
            continue;
        }
        last |= 1 << i;
    }
    opt = last;
    mask = 1;
    gen(1, n / 2 - 1, false);
    for (int i = 0; i < n; i++) {
        if ((opt >> i) & 1) {
            printf("%d ", i + 1);
        }
    }
    printf("\n");
    return 0;
}
