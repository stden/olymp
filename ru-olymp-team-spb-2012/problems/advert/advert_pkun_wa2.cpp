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

time_t __start_time__ = clock();

typedef long long ll;
typedef double ld;


const int MAXN = 110000;

int w,h;
int a[MAXN];
int b[MAXN];
int n;


int main(){
  freopen("advert.in","r",stdin);
  freopen("advert.out","w",stdout);

  scanf("%d %d %d",&n,&w,&h);
  for (int i = 0; i < n; i++)
    scanf("%d %d",&a[i],&b[i]);

  ld l = 0;
  ld r = 1e9+1;
  //for (int i = 0; i < n; i++)
  //  r = min(r,ld(w)/a[i]);

  for (int i = 0; i < 30; i++){
    double mid = (l+r)/2;
    double curh = 0;
    double curw = 0;

    for (int j = 0; j < n; j++){
        if (j == 0 || b[j] != b[j-1] || curw + a[j] * mid > w){
           curw = 0;
           curh += b[j] * mid;
        }
        curw += a[j] * mid;                                             
    }

    if (curh > h)
        r = mid;
    else
        l = mid;
  }

  cout.precision(15);
  cout << fixed << (l+r)/2 << endl;        
  cerr << "Time " << (clock () - __start_time__)*1.0/CLOCKS_PER_SEC << endl;
  return 0;
}