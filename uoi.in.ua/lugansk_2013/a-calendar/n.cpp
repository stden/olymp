#define maxn 100000

#include <stdio.h>

int n, i, c, maxcnt;
int a[maxn], b[maxn];   // a[i] (b[i]) — місце (нумерація з нуля), на якому стоїть у календарі першого (другого) племені число i+1, 0 <= i < n
int cnt[maxn];  // cnt[k] — кількість різниць a[i] - b[i], 0 <= i < n, які за модулем n дорівнюють k, 0 <= k < n

int main()
{
    freopen("calendar.dat", "r", stdin);
    freopen("calendar.sol", "w", stdout);

    /* Зчитування: */
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
    /* Кінець зчитування */

    for (i = 0; i < n; i++) // Ініціалізація масиву cnt
        cnt[i] = 0;
    for (i = 0; i < n; i++) // Заповнення масиву cnt
        cnt[(a[i] - b[i] + n) % n]++;

    maxcnt = 0; // Найбільше пройдене на даний момент число з масиву cnt
    for (i = 0; i < n; i++) // Визначаємо найбільше число масиву cnt
        if (cnt[i] > maxcnt)
            maxcnt = cnt[i];

    printf("%d\n", maxcnt); // Виведення

    return 0;
}
