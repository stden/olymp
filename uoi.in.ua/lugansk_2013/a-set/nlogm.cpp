#define maxn 100000

#include <stdio.h>

long long n, k, i, s, a[maxn], max_ind;
bool b[maxn];

int main()
{
    freopen("set.dat", "r", stdin);
    freopen("set.sol", "w", stdout);

    scanf("%d", &n);
    for (i = 0; i < n; i++)
        scanf("%d", &a[i]);

    for (i = 0; i < n; i++)
        b[i] = true;

    k = n;
    while (k > 0)
    {
        max_ind = -1;
        s = 0;
        for (i = 0; i < n; i++)
            if (b[i])
            {
                if (max_ind == -1 || a[max_ind] < a[i])
                    max_ind = i;
                s += a[i];
            }
        if (2 * a[max_ind] >= s)
        {
            b[max_ind] = false;
            k--;
        } else
            break;
    }

    printf("%d\n", k);

    return 0;
}
