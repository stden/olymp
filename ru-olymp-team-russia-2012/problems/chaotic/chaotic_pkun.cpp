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


int main(){
  freopen("chaotic.in","r",stdin);
  freopen("chaotic.out","w",stdout);
  
  scanf("%d",&n);
  assert(3 <= n && n <= 1000);
  for (int i = 0; i < n; i++){
     scanf("%d",&a[i]);
     assert(1 <= a[i] && a[i] <= n);
     if (i >= 2 && a[i-2] < a[i-1] && a[i-1] < a[i])
        ans.pb(i), swap(a[i],a[i-1]);
     else if (i >= 2 && a[i-2] > a[i-1] && a[i-1] > a[i])
        ans.pb(i), swap(a[i],a[i-1]); 
  }

  printf("%d\n",ans.size());
  for (int i = 0; i < (int)ans.size(); i++)
    printf("%d%c",ans[i]," \n"[i+1 == (int)ans.size()]);

      
  return 0;
}