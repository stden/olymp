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
int dp[1100][4200];
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
    freopen("tetris.dat","r",stdin);
    freopen("tetris.sol","w",stdout);    
    
     cin >> n;
    for (i=0;i<n;i++)        
        cin >> a[i];
        
    for (i=0;i<=n;i++)
        for (j=0;j<=let*n;j++)
            dp[i][j] = 1000000000;
            
    dp[0][0] = 0;
    
        
    for (i=0;i<n;i++)   
    {
        cin >> x;
        a[i] = (x-a[i]+let)%let;
        
        for (ost = 0;ost<=min(let*i,4*n-let*i+4);ost++)
        {
            for (j=max(0,ost-4);j<=ost;j++)
            {
                need = (a[i]-(j&3)+let)&3;
                all = need + j;
                if (dp[i+1][all]>dp[i][ost]+need) 
                   dp[i+1][all] = dp[i][ost] + need;
            }
//            cout << i << " " << ost << " " << dp[i][ost] << endl;
        }
    }
    /*
    5
    0 1 3 0 1
    3 1 0 1 0
    5
5
0 1 3 3 2 
3 2 2 3 1     
6
    */
        
    ans = 1000000000;
    for (ost=0;ost<=2*n;ost++)
        if (dp[n][ost]<ans) ans = dp[n][ost];
        
    cout << ans << endl;
    
    system("pause");
    return 0;
}
