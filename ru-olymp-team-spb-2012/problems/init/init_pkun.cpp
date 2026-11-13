#include <iostream>
#include <fstream>
#include <vector>
#include <set>
#include <map>
#include <string>
#include <cmath>
#include <cassert>
#include <ctime>
#include <algorithm>
#include <queue>
#include <memory.h>
#include <stack>
#define mp make_pair
#define pb push_back                     
#define setval(a,v) memset(a,v,sizeof(a))

#if ( _WIN32 || __WIN32__ )
    #define LLD "%I64d"
#else
    #define LLD "%lld"
#endif

using namespace std;

typedef long long ll;
typedef long double ld;


const int MOD = 1000000007;
const int MAXN = 110;

int pow(int a,int b){
    if (!b) return !!a;
    if (b&1)
        return (pow(a,b-1)*1LL*a)% MOD;
    int temp = pow(a,b/2);
    return (temp * 1LL * temp) % MOD;
}

int c[MAXN][MAXN];
int dp[MAXN][MAXN];
int all[MAXN][MAXN];


int main(){
  freopen("init.in","r",stdin);
  freopen("init.out","w",stdout);

  c[0][0] = 1;
  for (int i = 0; i < MAXN; i++)
    for (int j = 0; j < MAXN; j++){
        if (i) c[i][j] = (c[i][j] + c[i-1][j]) % MOD;
        if (i && j) c[i][j] = (c[i][j] + c[i-1][j-1]) % MOD;
    }

  int n,m;
  scanf("%d %d",&n,&m);

  for (int i = 0; i <= n; i++)
    for (int j = 0; j <= m; j++)
        all[i][j] = pow(i*(i+1)/2,j);

  all[0][0] = 1;

  for (int i = 0; i <= n; i++)
    for (int j = 0; j <= m; j++){
        dp[i][j] = all[i][j];
        for (int k = 0; k <= i; k++)
            for (int l = 0; l <= j; l++){
                dp[i][j] = (dp[i][j] - ((dp[k][l] * 1LL *c[j][l])%MOD *1LL* all[i-k-1][j-l])%MOD + MOD)%MOD;
             }
    }

  cout << dp[n][m] << endl;
      
  return 0;
}