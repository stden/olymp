#define maxn 5000
#define maxw 1000000000

#include <stdio.h>

int n, m, i, j, k, op, t, w, curmin, curmin_index, curmax, curmax_index, curmax_min_index;
int ws[maxn][maxn], cnt[maxn];

inline int getW(int town, int place)
{
    return ws[town][place];
}

inline void setW(int town, int place, int w)
{
    ws[town][place] = w;
}

inline void swap(int town, int place1, int place2)
{
    int tmp = getW(town, place1);
    setW(town, place1, getW(town, place2));
    setW(town, place2, tmp);
}

int main()
{
    freopen("stones.dat", "r", stdin);
    freopen("stones.sol", "w", stdout);

    scanf("%d%d", &n, &m);

    for (i = 0; i < m; i++)
        cnt[i] = 0;

    for (i = 0; i < n; i++)
    {
        scanf("%d", &op);
        if (op == 1)
        {
            scanf("%d%d", &t, &w);
            t--;
            setW(t, cnt[t], w);
            cnt[t]++;
        } else
        {
            curmax = 0;
            for (j = 0; j < m; j++)
            {
                curmin = maxw;
                for (k = 0; k < cnt[j]; k++)
                    if (getW(j, k) < curmin)
                    {
                        curmin = getW(j, k);
                        curmin_index = k;
                    }
                if (curmin > curmax)
                {
                    curmax = curmin;
                    curmax_index = j;
                    curmax_min_index = curmin_index;
                }
            }
            printf("%d\n", curmax);
            swap(curmax_index, curmax_min_index, cnt[curmax_index] - 1);
            cnt[curmax_index]--;
        }
    }

    return 0;
}
