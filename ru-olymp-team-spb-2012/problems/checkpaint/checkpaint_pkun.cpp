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


int x[11000];


int main(){
    freopen("checkpaint.in","r",stdin);
    freopen("checkpaint.out","w",stdout);

    int m,n;
    scanf("%d %d",&m,&n);

    for (int i = 0; i < n; i++){
        int a,b;
        scanf("%d %d",&a,&b);
        --a,--b;
        for (int j = a; j <= b; j++)
           x[j] = 1; 
    }

    if (find(x,x+m,0) != x+m)
        cout << "NO" << endl;
    else
        cout << "YES" << endl;
      
    return 0;
}