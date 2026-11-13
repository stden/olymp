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

const ld eps = 1e-9;

struct point{
	ld x,y;
	point(ld x,ld y):x(x),y(y){
	}
	point(){
	}
};

point corner;

point get(point p1,point p2,ld y){
	assert(p1.y != p2.y);
	return point(p1.x + (p2.x - p1.x) * (y - p1.y)/(p2.y - p1.y),y);
}

bool check(point c,point op,point np){
	double tmp = (op.x - c.x) * (np.y - c.y) - (op.y - c.y)*(np.x - c.x);
	return tmp > 0;
}



int main(){
  freopen("rag.in","r",stdin);
  freopen("rag.out","w",stdout);

  vector<point> v;
  int n;
  cin >>corner.x >>corner.y; 
  scanf("%d",&n);

  bool upper = false;

  point lp;
  cin >> lp.x >> lp.y;
  v.pb(lp);

  for (int i = 1; i < n; i++){
  	point np;
  	cin >> np.x >> np.y;
  	if (np.y < v.back().y + eps){
  		if (upper)
  			v.pb(get(lp,np,v.back().y)), upper = false;
        v.pb(np);  		
  	}
  	else {
		if (!upper){
			if (v.size() >= 2 && check(v.back(),v[v.size()-1],np))
				upper = true;
			else {
				while (v[v.size()-2].y < np.y){
					v.pop_back();
					assert(v.size() >= 2);
				}
				lp = v.back();
				v.pop_back();
				v.push_back(get(v.back(),lp,np.y));
				v.push_back(np);
			}
		}			  	
  	}
  	lp = np;
  }

  v.push_back(corner);

  double s = 0;
  v.pb(v[0]);

  for (int i = 0; i+1 < (int)v.size(); i++)	
	s += v[i].x * v[i+1].y - v[i].y * v[i+1].x;

  for (int i = 0; i < (int)v.size(); i++)
  	cerr << v[i].x <<" "<<v[i].y << endl;	

  cout.precision(15);
  cout << fixed << fabs(s)/2 << endl;	


      
  return 0;
}