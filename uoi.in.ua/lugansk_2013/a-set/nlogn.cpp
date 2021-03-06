#define maxn 100000

#include <stdio.h>
#include <algorithm>

using namespace std;

long long n, i, s;  // ����� ������� ���� ��� long long, ������� ���� ������ ������� ���� ������������ ������� ����� ���� int/long
long long a[maxn];  // ������� �������

int main()
{
    freopen("set.dat", "r", stdin);
    freopen("set.sol", "w", stdout);

    /* ����������: */
    scanf("%d", &n);
    for (i = 0; i < n; i++)
        scanf("%d", &a[i]);
    /* ʳ���� ���������� */

    sort(a, a + n); // ������� ������� � ��������� ������������ ������

    s = 0;
    for (i = 0; i < n; i++) // ������ ��������� �������� ����
        s += a[i];

    i = n;
    while (i > 0 && 2 * a[i - 1] >= s)  // ���� ���������� �� ���� � ���� ������� � ������� ������� �������� (��������) � ������� �� ����� �� ���� ���, ������� � ���
    {
        s -= a[i - 1];  // ³������� �� ������� � ������������ ����
        i--;
    }

    printf("%d\n", i);  // ��������, ������ ������� ����������

    return 0;
}
