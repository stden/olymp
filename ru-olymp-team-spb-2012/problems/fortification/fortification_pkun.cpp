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
const int MAXN = 110000;

int next1[MAXN];
int next2[MAXN];

bool used[MAXN];

int ans = 1;

void dfs(int a,int p,int len){
    if (next2[a] == p)
        swap(next1[a],next2[a]);
    used[a] = true;
    if (next2[a] == -1){
        return;
    }
    if (used[next2[a]]){
        ans = (ans *1LL* (len+1)) % MOD;
        return;
    } 
    return dfs(next2[a],a,len+1);
}


int main(){
  freopen("fortification.in","r",stdin);
  freopen("fortification.out","w",stdout);

  memset(next1,-1,sizeof(next1));
  memset(next2,-1,sizeof(next2));

  int n,m;
  scanf("%d %d",&n,&m);
  for (int i = 0; i < m; i++){
    int a,b;
    scanf("%d %d",&a,&b);
    --a,--b;
    ((next1[a] == -1)?next1[a]:next2[a]) = b;
    ((next1[b] == -1)?next1[b]:next2[b]) = a;
  }

  for (int i = 0; i < n; i++)
    if (!used[i] && next2[i] == -1)
        dfs(i,-1,0);
  for (int i = 0; i < n; i++)
    if (!used[i])
        dfs(i,-1,0);

  cout << ans << endl;      
  return 0;
}