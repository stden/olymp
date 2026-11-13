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

#define x first
#define y second

using namespace std;

typedef long long ll;
typedef long double ld;
typedef pair<int,int> point;

const int MAXN = 110000;


point p[MAXN];
int n;

int cury;

double pl[MAXN];
double pr[MAXN];

double getx(const point& p1,const point& p2,double y){
	if (p1.y == p2.y)
		return max(p1.x,p2.x);
	return p1.x + (p2.x - p1.x) * (y - p1.y) / (p2.y - p1.y);
}

struct Comparer{
    bool operator()(int a,int b){
        int l = max(pl[a],pl[b]);
        int r = min(pr[a],pr[b]);

        double compy = (l+r)/2.0;

    	double x1 = getx(p[a],p[a+1],compy);
    	double x2 = getx(p[b],p[b+1],compy);
    	if (fabs(x1-x2) < 1e-9)
    		return a < b;
    	return x1 < x2;
    }
};

int ord[MAXN];



bool cmpp(const pair<int,int>& a,const pair<int,int>& b){
	if (a.second != b.second)
		return a.second > b.second;
	return a.first < b.first;
}

bool cmp(int a,int b){
	return cmpp(p[a],p[b]);
}

set<int,Comparer> s;

void inverse(int prev){
	set<int,Comparer>::iterator iter = s.lower_bound(prev);
  	if (iter != s.end() && *iter == prev)
   		s.erase(iter);
   	else
   		s.insert(iter,prev);
}
               

int main(){
	time_t START = clock();
    freopen("rag.in","r",stdin);
    freopen("rag.out","w",stdout);

    double w,h;
    cin >> w>> h;
    scanf("%d",&n);
    for (int i = 1; i <= n; i++)
    	scanf("%d %d",&p[i].x,&p[i].y), ord[i-1] = i;
    p[++n] = point(w,0);
    ord[n-1] = n;
    p[n+1] = p[1];

    for (int i = 0; i < n; i++){
    	pl[i] = min(p[i].second, p[i+1].second);
    	pr[i] = max(p[i].second, p[i+1].second);
	}

    sort(ord,ord+n,cmp);
                        

    double ans = 0;
    cury = h;


    for (int i = 0; i <= n; i++){
		if (s.size()){
    		int id = *(--s.end());
    		double up = w - getx(p[id],p[id+1],cury);
    		double down = w - getx(p[id],p[id+1],p[ord[i]].y);
    		ans += (cury - p[ord[i]].y) * (up + down) / 2;
    	}

    	cury = p[ord[i]].y;   
    	

    	inverse(ord[i]);
	   	if (ord[i] != 1) inverse(ord[i]-1);
   	}

   	cout.precision(15);
    cout << fixed << ans << endl;

    cerr << (clock() - START)*1.0/CLOCKS_PER_SEC << endl;
      
    return 0;
}