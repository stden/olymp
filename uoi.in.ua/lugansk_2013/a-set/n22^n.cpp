#define maxn 100000

#include <stdio.h>

long long n, i, a[maxn], curmax;
bool b[maxn];

void check()
{
    bool will_do = true;
    long long i, j, s, total = 0;
    for (i = 0; i < n; i++)
        if (b[i])
        {
            total++;
            s = 0;
            for (j = 0; j < n; j++)
                if (b[j] && j != i)
                    s += a[j];
            if (a[i] >= s)
                will_do = false;
        }
    if (will_do && total > curmax)
        curmax = total;
}

void rec(int step)
{
    if (step == n)
        check();
    else
    {
        b[step] = false;
        rec(step + 1);
        b[step] = true;
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
