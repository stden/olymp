#define maxn 200000
#define maxm 100
#define maxw 1000000000

#include <stdio.h>

int n, m, i, j, k, op, t, w, curmin, curmin_index, curmax, curmax_index;
int ws[maxm][maxn], cnt[maxn];

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

inline void insert(int town, int w)
{
    int cur = cnt[town], newCur;
    setW(town, cur, w);
    cnt[town]++;
    while (cur > 0 && getW(town, cur) < getW(town, newCur = (cur - 1) / 2))
    {
        swap(town, cur, newCur);
        cur = newCur;
    }
}

inline void remove(int town)
{
    setW(town, 0, getW(town, cnt[town] - 1));
    cnt[town]--;
    int cur = 0, min, left, right;
    while (true)
    {
        left = 2 * cur + 1;
        right = left + 1;
        min = cur;
        if (left < cnt[town] && getW(town, left) < getW(town, min))
            min = left;
        if (right < cnt[town] && getW(town, right) < getW(town, min))
            min = right;
        if (min != cur)
        {
            swap(town, cur, min);
            cur = min;
        } else
            break;
    }
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
            insert(t, w);
        } else
        {
            curmax = 0;
            for (j = 0; j < m; j++)
                if (getW(j, 0) > curmax)
                {
                    curmax = getW(j, 0);
                    curmax_index = j;
                }
            printf("%d\n", curmax);
            remove(curmax_index);
        }
    }

    return 0;
}
