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

int n,m;

int tox1,toy1;
int tox2,toy2;

void closer(int& x,int tox,int& y,int toy,bool eq){
	if (x < tox) x++;
	else if (x > tox) x--;
	else if (y != toy || !eq) x = -1;	
}

struct state{
	int x1,y1;
	int x2,y2;
	int cnt;

	void go(int t1,int t2){
		if (t1) closer(x1,tox1,y1,toy1,1);
		if (!t1) closer(y1,toy1,x1,tox1,0);
		if (t2) closer(x2,tox2,y2,toy2,1);
		if (!t2) closer(y2,toy2,x2,tox2,0);
		if (x1 == x2 && y1 == y2)
			x1 = -1;
		if (x2 == -1 || y2 == -1 || y1 == -1)
			x1 = -1;		
	}

	bool operator<(const state& r) const{
		if (x1 != r.x1) return x1 < r.x1;
		if (x2 != r.x2) return x2 < r.x2;
		if (y1 != r.y1) return y1 < r.y1;
		if (y2 != r.y2) return y2 < r.y2;
		return false;
	}

	bool operator==(const state& r) const{
		if (x1 != r.x1) return false;
		if (x2 != r.x2) return false;
		if (y1 != r.y1) return false;
		if (y2 != r.y2) return false;
		return true;
	}

	bool finished() const{
		return x1 == tox1 && y1 == toy1 && y2 == toy2 && x2 == tox2;
	}

};

vector<state> curst;
vector<state> nst;

const int MOD = 1000000007;

void ADD(int& a,int b){
	if ((a += b) >= MOD) a-= MOD;
}


int main(){
  freopen("kitten.in","r",stdin);
  freopen("kitten.out","w",stdout);

  cin >> n >> m;
  cin >> tox1 >> toy1;
  int x,y;
  cin >> x >> y;
  cin >> tox2 >> toy2;
  
  for (int i = 0; i < 2; i++){
    if (tox1 == tox2 && tox1 == x){
    	if ((y > toy1 && y > toy2) || (y < toy1 && y < toy2)){
    		if (x == 1 || x == n)
    			printf("%d\n",abs(toy1-toy2)); 
    		else
    			printf("%d\n",2*abs(toy1-toy2));
    		return 0;
    	}
    }
  	swap(tox1,toy1);
  	swap(tox2,toy2);
  	swap(x,y);
  	swap(n,m);
  }

  {
  	state tmp;
  	tmp.x1 = tmp.x2 = x;
  	tmp.y1 = tmp.y2 = y;
  	tmp.cnt = 1;
  	curst.pb(tmp);
  }

  state bad;
  bad.x1 = -1;

  while (!curst[0].finished()) {
  	 nst.clear();
  	 for (int i = 0; i < (int)curst.size(); i++)
  	 	for (int j = 0; j < 2; j++)
  	 		for (int k = 0; k < 2; k++){
  	 			state tmp = curst[i];
  	 			tmp.go(j,k);
  	 			if (tmp.x1 != -1){
  	 				nst.pb(tmp);
  	 			}
  	 		}
  	curst.clear();
	sort(nst.begin(),nst.end());
	nst.pb(bad);
	for (int i = 1; i < (int)nst.size(); i++)
		if (nst[i] == nst[i-1])
			ADD(nst[i].cnt,nst[i-1].cnt);
		else
			curst.pb(nst[i-1]);

	assert(curst.size());
  }	
  cout << curst[0].cnt << endl;      
  return 0;
}