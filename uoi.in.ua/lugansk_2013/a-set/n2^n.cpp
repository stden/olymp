#define maxn 100000

#include <stdio.h>

long long n, i, a[maxn], curmax;
bool b[maxn];

void check()
{
    long long max = 0, s = 0, total = 0, i;
    for (i = 0; i < n; i++)
        if (b[i])
        {
            if (a[i] > max)
                max = a[i];
            s += a[i];
            total++;
        }
    if (2 * max < s && curmax < total)
        curmax = total;
}

void rec(int step)
{
    if (step == n)
        check();
    else
    {
        b[step] = true;
        rec(step + 1);
        b[step] = false;
        rec(step + 1);
    }
}

int main()
{
    freopen("set.dat", "r", stdin);
    freopen("set.sol", "w", stdout);

    scanf("%d", &n);
    for (i = 0; i < n; i++)
        scanf("%d", &a[i]);

    curmax = 0;
    rec(0);

    printf("%d\n", curmax);

    return 0;
}
