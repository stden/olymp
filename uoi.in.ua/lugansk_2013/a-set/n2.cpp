#define maxn 100000

#include <stdio.h>

long long n, i, j, min_ind, s, t, a[maxn];

int main()
{
    freopen("set.dat", "r", stdin);
    freopen("set.sol", "w", stdout);

    scanf("%d", &n);
    for (i = 0; i < n; i++)
        scanf("%d", &a[i]);

    for (i = 0; i < n; i++)
    {
        min_ind = i;
        for (j = i + 1; j < n; j++)
            if (a[j] < a[min_ind])
                min_ind = j;
        t = a[min_ind];
        a[min_ind] = a[i];
        a[i] = t;
    }

    s = 0;
    for (i = 0; i < n; i++)
        s += a[i];

    i = n;
    while (i > 0 && 2 * a[i - 1] >= s)
    {
        s -= a[i - 1];
        i--;
    }

    printf("%d\n", i);

    return 0;
}
