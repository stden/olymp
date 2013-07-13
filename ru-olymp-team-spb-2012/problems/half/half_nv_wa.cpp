#include <iostream>
#include <cstdio>
#include <set>
#include <vector>
#include <iterator>

using namespace std;

int main()
{
    freopen("half.in", "r", stdin);
    freopen("half.out", "w", stdout);
    int n, k;
    cin >> n >> k;
    set<int> ans;
    ans.insert(2 * n);
    for (int i = 0; i < k; i++)
    {
        set<int> tmp;
        for (set<int>::iterator it = ans.begin(); it != ans.end();  it++)
        {
            tmp.insert(*it - 1);
            if ((*it) % 2 == 0) tmp.insert(*it / 2);
        }
       ans = tmp;
    }
    cout << ans.size() << endl;
    for (set<int>::iterator it = ans.begin(); it != ans.end();  it++)
        cout << fixed << double(*it) / 2 <<  " ";
}