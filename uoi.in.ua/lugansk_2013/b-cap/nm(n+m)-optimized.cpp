#define maxn 1000

#include <stdio.h>

int n, m, i, j, i1, j1, i2, j2, a[maxn][maxn], q_i[maxn * maxn], q_j[maxn * maxn], q_cnt, q_cur, cur_i, cur_j, cur_step;
int i_index[maxn][maxn], j_index[maxn][maxn], i_index_cnt[maxn], j_index_cnt[maxn];
char c;

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
                    a[i][j] = -2;
                    break;
                case 'x':
                    a[i][j] = -1;
                    break;
                case 'o':
                    a[i][j] = 0;
                    i1 = i;
                    j1 = j;
                    break;
                case '+':
                    a[i][j] = -1;
                    i2 = i;
                    j2 = j;
                    break;
            }
        }
        scanf("\n");
    }

    for (i = 0; i < n; i++)
    {
        i_index_cnt[i] = 0;
        for (j = 0; j < m; j++)
            if (a[i][j] != -2)
            {
                i_index[i][i_index_cnt[i]] = j;
                i_index_cnt[i]++;
            }
    }

    for (j = 0; j < m; j++)
    {
        j_index_cnt[j] = 0;
        for (i = 0; i < n; i++)
            if (a[i][j] != -2)
            {
                j_index[j][j_index_cnt[j]] = i;
                j_index_cnt[j]++;
            }
    }

    q_cnt = 1;
    q_i[0] = i1;
    q_j[0] = j1;
    q_cur = 0;

    while (q_cur < q_cnt && a[i2][j2] == -1)
    {
        cur_i = q_i[q_cur];
        cur_j = q_j[q_cur];
        cur_step = a[cur_i][cur_j] + 1;
        for (i = 0; i < i_index_cnt[cur_i]; i++)
            if (a[cur_i][i_index[cur_i][i]] == -1)
            {
                a[cur_i][i_index[cur_i][i]] = cur_step;
                q_i[q_cnt] = cur_i;
                q_j[q_cnt] = i_index[cur_i][i];
                q_cnt++;
            }
        for (j = 0; j < j_index_cnt[cur_j]; j++)
            if (a[j_index[cur_j][j]][cur_j] == -1)
            {
                a[j_index[cur_j][j]][cur_j] = cur_step;
                q_i[q_cnt] = j_index[cur_j][j];
                q_j[q_cnt] = cur_j;
                q_cnt++;
            }
        q_cur++;
    }

    printf("%d\n", a[i2][j2]);

    return 0;
}
