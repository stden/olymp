#include <iostream>
#include <cstdio>
#include <vector>

using namespace std;

int main()
{
    freopen("checkpaint.in", "r", stdin);
    freopen("checkpaint.out", "w", stdout);
    int m, n;
    cin >> m >> n;
    vector<int> a(m + 1, 0);
    for (int i = 0; i < n; i++)
    {
        int l, r;
        cin >> l >> r;
        for (int j = l; j <= r; j++)
            a[j] = 1;
    }

    int sum = 0;
    for (size_t i = 0; i < a.size(); i++)
        sum += a[i];

    cout << (sum == m ? "YES\n" : "NO\n");
}