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


int main(){
    freopen("vikings.in","r",stdin);
    freopen("vikings.out","w",stdout);

    double r,l;
    cin >> r >> l;

    if (l >= 2*r){
        cout.precision(15);
        cout << fixed << 0.0 <<" "<<-r << endl;
        cout << fixed << 0.0 <<" "<<r << endl;
        return 0;
    }

    double alpha = acos(-(l*l - r*r - r*r)/(2*r*r));

    cout.precision(15);
    
    cout << fixed << r <<" "<<0 << endl;
    cout << fixed << r * cos(alpha) <<" "<<r * sin(alpha) << endl;
      
    return 0;
}