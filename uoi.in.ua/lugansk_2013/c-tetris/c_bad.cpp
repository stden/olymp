#include <iostream>
#include <cstdlib>
#include <cstring>
#include <iomanip>
#include <algorithm>
#include <map>
#include <vector>
#include <cstdio>
#include <cmath>

using namespace std;

int n,i,x,j,ost,num,need,all,ans;
int a[100000];
int dp[1100][4000];
int let = 4;
string s;

int get(char v)
{
    if (v == 'A') return 0;
    if (v == 'G') return 1;
    if (v == 'T') return 2;
    if (v == 'V') return 3;            
}

int main()
{
    freopen("a.dat","r",stdin);
    freopen("a.sol","w",stdout);    
    
    cin >> s;
    n = s.size();
    for (i=0;i<n;i++)        
        a[i] = get(s[i]);
        
    for (i=0;i<=n;i++)
        for (j=0;j<=let;j++)
            dp[i][j] = 1000000000;
            
    dp[0][0] = 0;
    
    cin >> s;
        
    for (i=0;i<n;i++)   
    {
        x = get(s[i]);
        a[i] = (x-a[i]+let)%let;
        
        for (ost = 0;ost<=let;ost++)
        {
            for (j=0;j<=ost;j++)
            {
                need = (a[i]-j%let+let)%let;
                all = need + j;
                if (all > let) all = let;
                if (dp[i+1][all]>dp[i][ost]+need) 
                   dp[i+1][all] = dp[i][ost] + need;
            }
//            cout << i << " " << ost << " " << dp[i][ost] << endl;
        }
    }
        
    ans = 1000000000;
    for (ost=0;ost<=let;ost++)
        if (dp[n][ost]<ans) ans = dp[n][ost];
        
    cout << ans << endl;
    
  //  system("pause");
    return 0;
}
