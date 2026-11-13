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
#define mp make_pair

vector <pair <int,int> > a;

pair <int,int> rec(int i){
	if(i==1)
		return mp(7,2);
	pair <int,int> t=rec(i-1);
	t.fs+=a[i].fs+a[i-1].fs;
	t.sc+=a[i].sc+a[i-1].sc;
	return t;
}

int getsum(int l){
	if(l==0)
		return 0;
	if(l==17)
		return 7;
	vector <int> number;
	if(a.empty())
		a.push_back(mp(1,0));
	while(a[a.size()-1].fs<l){
		a.push_back(mp(5*a[a.size()-1].fs+2*a[a.size()-1].sc,
						2*a[a.size()-1].fs+a[a.size()-1].sc));
	}
	while(a[a.size()-1].fs>l){
		a.pop_back();
	}
// 	cerr<<a[a.size()-1].fs<<' '<<a[a.size()-1].sc;
// 	cerr<<endl;
	forn(i,a.size())
		number.push_back(0);
	/*forn(asdf,a.size())
		cerr<<a[asdf].fs<<' '<<a[asdf].sc<<endl;*/
	int i=a.size()-1;
	pair <int,int> b=a[i];
	while(i>0 && b.fs!=l){
		pair<int,int>c=b;
		if(number[i]==0 || number[i]%2)
			c.fs+=a[i].fs,c.sc+=a[i].sc;
		else{
			pair <int,int> t=rec(i);
			c.fs+=t.fs;
			c.sc+=t.sc;
		}
		if(c.fs<=l){
			b=c;
			number[i]++;
		}else
			i--;
	}
	return b.sc;
}

int main(){
	freopen("digitsum.in","rt",stdin);
	freopen("digitsum.out","wt",stdout);
	int n;
	cin>>n;
	forn(sdfgsdg,n){
		int l,r;
		scanf("%d %d",&l,&r);
		l--;
		printf("%d\n",getsum(r)-getsum(l)+r-l);
	}
	return 0;
}

//powered by Kate
//powered by bash script