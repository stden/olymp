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

int a[30][30],half[30],bad[30];

int main(){
	freopen("half.in","rt",stdin);
	freopen("half.out","wt",stdout);
	int n,m;
	cin>>n>>m;
	forn(i,m){
		int x,y;
		cin>>x>>y;
		a[--x][--y]=1;
		a[y][x]=1;
	}
	forn(i,n)
		half[i]=1;
	forn(i,n){
		bad[i]=0;
		forn(j,n)
			bad[i]+=a[i][j];
	}
	forn(sdfgs,n/2){
		int k=n-1;
		forn(i,n-1)
			if(bad[i]<bad[k])
				k=i;
		half[k]=-1;
		forn(i,n)if(half[i]==1){
			bad[i]=0;
			forn(j,n)
				bad[i]+=a[i][j]*half[j];
		}else
			bad[i]=1000000000;
	}
	forn(i,n)
		if(half[i]==-1)
			cout<<i+1<<' ';
	return 0;
}

//powered by Kate
//powered by bash script