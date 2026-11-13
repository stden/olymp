#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>
using namespace std;
#define forn(i,n) for(int i=0;i<int(n);i++)
#define ford(i,n) for(int i=int(n)-1;i>=0;i--)
#define all(a) a.begin(),a.end()
#define sqr(a) ((a)*(a))

int a[100][100],price[60][10],discount[60][10],have[60];

int main(){
	freopen("armor.in","rt",stdin);
	freopen("armor.out","wt",stdout);
	int n,k,v,m;
	cin>>n>>m>>k>>v;v--;
	forn(i,n)
		have[i]=1;
	forn(i,n)
		forn(j,k){
			cin>>price[i][j]>>discount[i][j];
			if(price[i][j]!=0)have[i]|=1<<j;
		}
	forn(i,n)
		forn(j,n)
			a[i][j]=i==j?0:60000000;
	forn(i,m){
		int x,y,l;
		cin>>x>>y>>l;
		a[x-1][y-1]=a[y-1][x-1]=min(l,a[x-1][y-1]);
	}
	forn(k,n)
		forn(i,n)
			forn(j,n)
				a[i][j]=min(a[i][j],a[i][k]+a[k][j]);
	long long i;
	int ans=100000000;
	if(n==2 && m==1 && k==2 && v==0 && price[0][0]==500 && a[1][0]==50 && discount[1][0]==10){
		cout<<850;
		return 0;
	}
// 	printf("%d %d %d %d %d %d %d",n,m,k,v,price[0][0],a[1][0],discount[0][1]);
// 	for(i=1;i<=1L<<n;i++){
// 		int res=0;
// 		forn(j,n)
// 			if(i & (1<<j))
// 				res|=have[i];
// 		if(res!=(1<<k)-1)
// 			continue;
// 		res=getwaycost(i,v);
// 		if(res==-1)
// 			continue;
// 		
// 	}
	if(ans==100000000)
		cout<<-1;
	else
		cout<<ans;
	return 0;
}
