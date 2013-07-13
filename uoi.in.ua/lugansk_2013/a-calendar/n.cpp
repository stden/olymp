#define maxn 100000

#include <stdio.h>

int n, i, c, maxcnt;
int a[maxn], b[maxn];   // a[i] (b[i]) � ���� (��������� � ����), �� ����� ����� � �������� ������� (�������) ������ ����� i+1, 0 <= i < n
int cnt[maxn];  // cnt[k] � ������� ������ a[i] - b[i], 0 <= i < n, �� �� ������� n ��������� k, 0 <= k < n

int main()
{
    freopen("calendar.dat", "r", stdin);
    freopen("calendar.sol", "w", stdout);

    /* ����������: */
    scanf("%d", &n);
    for (i = 0; i < n; i++)
    {
        scanf("%d", &c);
        a[c - 1] = i;
    }
    for (i = 0; i < n; i++)
    {
        scanf("%d", &c);
        b[c - 1] = i;
    }
    /* ʳ���� ���������� */

    for (i = 0; i < n; i++) // ����������� ������ cnt
        cnt[i] = 0;
    for (i = 0; i < n; i++) // ���������� ������ cnt
        cnt[(a[i] - b[i] + n) % n]++;

    maxcnt = 0; // �������� �������� �� ����� ������ ����� � ������ cnt
    for (i = 0; i < n; i++) // ��������� �������� ����� ������ cnt
        if (cnt[i] > maxcnt)
            maxcnt = cnt[i];

    printf("%d\n", maxcnt); // ���������

    return 0;
}
