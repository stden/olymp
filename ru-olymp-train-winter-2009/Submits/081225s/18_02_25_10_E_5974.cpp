#include <vector>
#include <list>
#include <map>
#include <set>
#include <deque>
#include <stack>
#include <bitset>
#include <algorithm>
#include <functional>
#include <numeric>
#include <utility>
#include <sstream>
#include <iostream>
#include <iomanip>
#include <cstdio>
#include <cmath>
#include <cstdlib>
#include <ctime>
using namespace std;
#define forn(i,n) for(int i=0;i<int(n);i++)
#define ford(i,n) for(int i=int(n)-1;i>=0;i--)
#define all(a) a.begin(),a.end()
#define sqr(a) ((a)*(a))
#define fs first
#define sc second
#define elif else if

int main(){
	freopen("marked.in","rt",stdin);//!!!wt!!!rt!!!
	freopen("marked.out","wt",stdout);
	int n,x,y,mask=0,mask2=0;
	cin>>n>>x>>y;
	vector <int> __set;
	forn(i,x){
		int k;
		cin>>k;
		__set.clear();
		forn(i,k){
			int r;
			cin>>r;
			__set.push_back(r);
		}
		forn(i,k)
			mask|=1<<__set[i];
	}
	forn(i,y){
		int k;
		cin>>k;
		__set.clear();
		forn(i,k){
			int r;
			cin>>r;
			__set.push_back(r);
		}
		forn(i,k)
			mask2|=1<<__set[i];
	}
	bool a[1024];
	forn(i,1<<n)
		a[i]=((mask | i)==mask);
	forn(i,1<<n)
		a[i]=((mask2 | i)==mask2)?1:a[i];
	int count=0;
	forn(i,1<<n)
		count+=a[i];
	cout<<count;
	return 0;
}

//powered by Kate
//powered by bash script