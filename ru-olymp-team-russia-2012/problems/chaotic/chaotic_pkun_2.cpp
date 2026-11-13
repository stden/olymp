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

const int MAXN = 1100;

int a[MAXN];
int n;
vector<int> ans;

bool check(int x){
    if (!x) return false;
    return !((a[x-1] < a[x]) ^ (a[x] < a[x+1]));
}


int main(){
  freopen("chaotic.in","r",stdin);
  freopen("chaotic.out","w",stdout);
  
  scanf("%d",&n);
  assert(3 <= n && n <= 1000);
  for (int i = 1; i <= n; i++){
     scanf("%d",&a[i]);
     assert(1 <= a[i] && a[i] <= n);
  }

  for (int i = 3-(n&1); i <= n; i+=2){
    if (check(i)){
        if (check(i-1)){
            swap(a[i-1],a[i]);
            ans.pb(i-1);
        } else {
            swap(a[i],a[i+1]);
            ans.pb(i);
        }
    } else {
        if (check(i-1)){
           swap(a[i-1],a[i]);
           ans.pb(i-1);
           if (check(i)){
             swap(a[i-1],a[i]);
             swap(a[i],a[i+1]);
             ans.back() = i;
           }                
        }
    }                          
  }

  printf("%d\n",ans.size());
  for (int i = 0; i < (int)ans.size(); i++)
    printf("%d%c",ans[i]," \n"[i+1 == (int)ans.size()]);
  return 0;
}