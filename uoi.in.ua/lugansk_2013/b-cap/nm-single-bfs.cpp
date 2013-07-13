#define maxn 1000

#include <stdio.h>
#include <algorithm>
#include <vector>

using namespace std;

int n, m, i, j, k, i1, j1, i2, j2, q_cnt, q_cur, q_step, q[2 * maxn + 1], l[2 * maxn + 1], d1, d2, d3, d4, d;
char c;
bool a[maxn][maxn];
vector<int> e[2 * maxn + 1];

int main()
{
    freopen("cap.dat", "r", stdin);
    freopen("cap.sol", "w", stdout);

    scanf("%d %d\n", &n, &m);
    for (i = 0; i < n; i++)
    {
        for (j = 0; j < m; j++)
        {
            scanf("%c", &c);
            switch (c)
            {
                case '.':
                    a[i][j] = false;
                    break;
                case 'x':
                    a[i][j] = true;
                    break;
                case 'o':
                    a[i][j] = true;
                    i1 = i;
                    j1 = j;
                    break;
                case '+':
                    a[i][j] = true;
                    i2 = i;
                    j2 = j;
                    break;
            }
        }
        scanf("\n");
    }

    for (i = 0; i < n; i++)
        for (j = 0; j < m; j++)
            if (a[i][j])
            {
                e[i].push_back(n + j);
                e[n + j].push_back(i);
            }

    e[n + m].push_back(i1);
    e[n + m].push_back(n + j1);

    for (k = 0; k < n + m; k++)
        l[k] = -1;
    l[n + m] = 0;
    q_cnt = 1;
    q[0] = n + m;
    q_cur = 0;

    while (q_cur < q_cnt)
    {
        q_step = l[q[q_cur]] + 1;
        for (k = 0; k < e[q[q_cur]].size(); k++)
            if (l[e[q[q_cur]][k]] == -1)
            {
                l[e[q[q_cur]][k]] = q_step;
                q[q_cnt] = e[q[q_cur]][k];
                q_cnt++;
            }
        q_cur++;
    }

    printf("%d\n", min(l[i2], l[n + j2]));

    return 0;
}
