#define maxn 100000

#include <stdio.h>

int n, i, j, a[maxn], b[maxn], cnt, maxcnt;

int main()
{
    freopen("calendar.dat", "r", stdin);
    freopen("calendar.sol", "w", stdout);

    scanf("%d", &n);
    for (i = 0; i < n; i++)
        scanf("%d", &a[i]);
    for (i = 0; i < n; i++)
        scanf("%d", &b[i]);

    maxcnt = 0;
    for (i = 0; i < n; i++)
    {
        cnt = 0;
        for (j = 0; j < n; j++)
            if (a[j] == b[(i + j) % n])
                cnt++;
        if (cnt > maxcnt)
            maxcnt = cnt;
    }

    printf("%d\n", maxcnt);

    return 0;
}
