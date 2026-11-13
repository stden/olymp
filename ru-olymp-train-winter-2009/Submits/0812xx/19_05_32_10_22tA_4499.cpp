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

struct vertex{
	int sum,max,min,plus;
	vertex(){sum=max=plus=min=0;}
};

vertex a[500000];
int st,n;

int left(int i){
	while(i<st)
		i*=2;
	return i;
}
int right(int i){
	while(i<st)
		i=i*2+1;
	return i;
}

void init(int _n){
	n=_n;
	st=1;
	while(st<n)
		st*=2;
	forn(i,st+n)
		a[i].sum=a[i].max=a[i].plus=a[i].min=0;
	for(int i=st+n;i<400000;i++)
		a[i].max=a[i].sum=0,a[i].min=1000000000;
}

void uptodate(int i){
	if(i>=st){
		a[i].max=a[i].min=a[i].sum=a[i].plus;
		return;
	}
	a[i].max=max(i*2<st+n?a[i*2].max:0,i*2+1<st+n?a[i*2+1].max:0)+a[i].plus;
	a[i].min=min(i*2<st+n?a[i*2].min:100,i*2<st+n?a[i*2+1].min:100)+a[i].plus;
	a[i].sum=(i*2<st+n?a[i*2].sum:0)+(i*2<st+n?a[i*2+1].sum:0)+a[i].plus*(min(right(i),st+n-1)-left(i)+1);
}

void _set(int l,int r,int i){
	int il=left(i),ir=right(i);
	if(ir<l || il>r || i>=st+n)
		return;
	if(il>=l && ir<=r){
		a[i].plus++;
		uptodate(i);
		return;
	}
	if(i>st)
		puts("buggy");
	_set(l,r,i*2);
	_set(l,r,i*2+1);
	uptodate(i);
}

int _get(int l,int r,int i){
	int il=left(i),ir=right(i);
	if(ir<l || il>r || i>=st+n)
		return 0;
	if(il>=l && ir<=r){
		return a[i].sum;
	}
	if(i*2<st+n)a[i*2].plus+=a[i].plus;
	if(i*2+1<st+n)a[i*2+1].plus+=a[i].plus;
	a[i].plus=0;
	if(i*2<st+n)uptodate(i*2);
	if(i*2+1<st+n)uptodate(i*2+1);
	return _get(l,r,i*2)+_get(l,r,i*2+1);
}

void check_max(int k,int i){
	if(a[i].max<k || i>=st+n)
		return;
	if(a[i].max==a[i].min){
		a[i].plus-=a[i].max-(a[i].max%k);
		uptodate(i);
		return;
	}
	if(i*2<st+n)a[i*2].plus+=a[i].plus;
	if(i*2+1<st+n)a[i*2+1].plus+=a[i].plus;
	a[i].plus=0;
	if(i*2<st+n)uptodate(i*2);
	if(i*2+1<st+n)uptodate(i*2+1);
	check_max(k,i*2);
	check_max(k,i*2+1);
	uptodate(i);
}

int main(){
	freopen("sum.in","rt",stdin);
	freopen("sum.out","wt",stdout);
	int n,k,m;
	cin>>n>>k>>m;
	init(n);
	forn(dgfdgs,m){
		int type,l,r;
		scanf("%d %d %d",&type,&l,&r);
		l+=st-1,r+=st-1;
		forn(i,st+n)
		/*	cerr<<a[i].max<<' '<<a[i].min<<' '<<a[i].sum<<' '<<a[i].plus<<endl;
		cerr<<endl;
		*/if(type==1){
			_set(l,r,1);
		}else{
			check_max(k,1);
			printf("%d\n",_get(l,r,1));
		}
	}
	return 0;
}

//powered by Kate
//powered by bash