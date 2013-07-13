#include <iostream>
#include <cstdio>
#include <string>

using namespace std;

int main()
{
    freopen("rebus.in", "r", stdin);
    freopen("rebus.out", "w", stdout);
    string ans = "", s = "";
    while (cin >> s)
    {
       int be = 0, en = 0;
       while (be < s.length() && s[be] == '\'') be++;
       while (en < s.length() && s[s.length() - 1 - en] == '\'') en++;
       ans += s.substr(2 * be, s.length() - 2 * be - 2 * en);
    }
    cout << ans << endl;
}