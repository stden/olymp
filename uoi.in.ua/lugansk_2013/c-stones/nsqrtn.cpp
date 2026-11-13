#define maxn 200000
#define maxw 1000000000

#include <stdio.h>
#include <math.h>

int n, m, i, j, op, t, w;
int c[maxn], ws[maxn], ws_start[maxn], sizes[maxn], cnt[maxn], min[maxn], min_indices[maxn], min_total[maxn], min_total_index[maxn];
int ws2[maxn], towns2[maxn], size2, cnt2, max2[maxn], max2_indices[maxn], max2_total, max2_total_index, town_index[maxn];

inline int getW(int town, int place)
{
    return ws[ws_start[town] + place];
}

inline void setW(int town, int place, int w)
{
    ws[ws_start[town] + place] = w;
}

inline void swap(int town, int place1, int place2)
{
    int tmp = getW(town, place1);
    setW(town, place1, getW(town, place2));
    setW(town, place2, tmp);
}

inline void insert2(int w, int town_from)
{
    int place = cnt2;
    cnt2++;
    ws2[place] = w;
    towns2[place] = town_from;
    town_index[town_from] = place;

    int set = place / size2;
    if (max2[set] < w)
    {
        max2[set] = w;
        max2_indices[set] = place;
        if (max2_total < w)
        {
            max2_total = w;
            max2_total_index = place;
        }
    }
}

inline void updateSet2(int set)
{
    int curmax = 0, curmax_index = -1;
    int maxi = (set + 1) * size2;
    if (maxi > cnt2)
        maxi = cnt2;
    for (int i = set * size2; i < maxi; i++)
        if (ws2[i] > curmax)
        {
            curmax = ws2[i];
            curmax_index = i;
        }
    max2[set] = curmax;
    max2_indices[set] = curmax_index;
}

inline void updateTotal2()
{
    int curmax = 0, curmax_index = -1;
    for (int i = 0; i < size2; i++)
        if (max2[i] > curmax)
        {
            curmax = max2[i];
            curmax_index = max2_indices[i];
        }
    max2_total = curmax;
    max2_total_index = curmax_index;
}

inline void update2(int w, int town_from)
{
    int place = town_index[town_from];
    ws2[place] = w;
    int set = place / size2;
    if (max2_indices[set] == place)
    {
        updateSet2(set);
        if (max2_total_index == place)
            updateTotal2();
    }
}

inline void insert(int town, int w)
{
    int place = cnt[town];
    setW(town, place, w);
    cnt[town]++;

    int set = place / sizes[town];
    if (min[ws_start[town] + set] > w)
    {
        min[ws_start[town] + set] = w;
        min_indices[ws_start[town] + set] = place;
        if (min_total[town] > w)
        {
            min_total[town] = w;
            min_total_index[town] = place;

            if (cnt[town] == 1)
                insert2(w, town);
            else
                update2(w, town);
        }
    }
}

inline void updateSet(int town, int set)
{
    int curmin = maxw, curmin_index = -1;
    int maxi = (set + 1) * sizes[town];
    if (maxi > cnt[town])
        maxi = cnt[town];
    for (int i = set * sizes[town]; i < maxi; i++)
        if (getW(town, i) < curmin)
        {
            curmin = getW(town, i);
            curmin_index = i;
        }
    min[ws_start[town] + set] = curmin;
    min_indices[ws_start[town] + set] = curmin_index;
}

inline void updateTotal(int town)
{
    int curmin = maxw, curmin_index = -1;
    for (int i = 0; i < sizes[town]; i++)
        if (min[ws_start[town] + i] < curmin)
        {
            curmin = min[ws_start[town] + i];
            curmin_index = min_indices[ws_start[town] + i];
        }
    min_total[town] = curmin;
    min_total_index[town] = curmin_index;
}

inline void remove(int town)
{
    int set1 = min_total_index[town] / sizes[town], set2 = (cnt[town] - 1) / sizes[town];
    setW(town, min_total_index[town], getW(town, cnt[town] - 1));
    cnt[town]--;

    updateSet(town, set1);
    if (set2 != set1)
        updateSet(town, set2);
    updateTotal(town);
}

inline int remove2()
{
    int result = max2_total;
    int town_from = towns2[max2_total_index];
    int set1 = max2_total_index / size2, set2 = (cnt2 - 1) / size2;

    ws2[max2_total_index] = ws2[cnt2 - 1];
    towns2[max2_total_index] = towns2[cnt2 - 1];
    town_index[towns2[max2_total_index]] = max2_total_index;
    town_index[town_from] = -1;
    cnt2--;

    updateSet2(set1);
    if (set2 != set1)
        updateSet2(set2);
    updateTotal2();

    remove(town_from);
    if (cnt[town_from] > 0)
        insert2(min_total[town_from], town_from);

    return result;
}

inline int getSize(int k)
{
    int result = sqrt(k);
    while (result * result < k)
        result++;
    return result;
}

int main()
{
    freopen("stones.dat", "r", stdin);
    freopen("stones.sol", "w", stdout);

    scanf("%d%d", &n, &m);

    for (i = 0; i < m; i++)
        c[i] = 0;
    for (i = 0; i < n; i++)
    {
        scanf("%d", &op);
        if (op == 1)
        {
            scanf("%d%d", &t, &w);
            t--;
            c[t]++;
        }
    }
    ws_start[0] = 0;
    for (i = 1; i < m; i++)
        ws_start[i] = ws_start[i - 1] + c[i - 1];

    for (i = 0; i < m; i++)
    {
        sizes[i] = getSize(c[i]);
        for (j = 0; j < sizes[i]; j++)
            min[ws_start[i] + j] = maxw;
        min_total[i] = maxw;
    }


    freopen("stones.dat", "r", stdin);

    scanf("%d%d", &n, &m);

    cnt2 = 0;
    for (i = 0; i < m; i++)
    {
        cnt[i] = 0;
        town_index[i] = -1;
    }

    size2 = getSize(m);
    for (i = 0; i < size2; i++)
        max2[i] = 0;
    max2_total = 0;

    for (i = 0; i < n; i++)
    {
        scanf("%d", &op);
        if (op == 1)
        {
            scanf("%d%d", &t, &w);
            t--;
            insert(t, w);
        } else
            printf("%d\n", remove2());
    }

    return 0;
}
