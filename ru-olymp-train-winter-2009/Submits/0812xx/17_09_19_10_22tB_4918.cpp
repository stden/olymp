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
#define head(a) (*a.begin())

int n;

set < vector<int> > used;

struct flow{
	long long a[50][50],f;
	vector<int> mask,used;
	int last;
	void dfs(int v){
		used[v]=0;
		forn(i,n)
			if(a[v][i]!=0 && used[i]==1)
				dfs(i);
	}
	vector <int> find_cut(){
		long long a1[50][50];
		forn(i,n)
			forn(j,n)
				a1[i][j]=a[i][j];
		used.clear();
		forn(i,n)
			used.push_back(1);
		int h[50],last[50];
		long long d[50];
		h[0]=n;
		for(int i=1;i<n;i++){
			d[i]=a[0][i];
			a[i][0]+=a[0][i];
			a[0][i]=0;
			h[i]=last[i]=0;
		}
		bool b=true;
		while(b){
			b=false;
			for(int i=1;i<n-1;i++){
				while(d[i]){
					b=true;
					for(int j=0/*last[i]*/;j<n;j++)
					  if(h[i]==h[j]+1){
						long long x=min(a[i][j],d[i]);
						d[i]-=x;
						d[j]+=x;
						a[i][j]-=x;
						a[j][i]+=x;
						last[i]=j;
					}
					if(d[i]){
// 						last[i]=0;
						h[i]++;
					}
				}
			}
		}
		f=d[n-1];
		dfs(0);
		forn(i,n)
			forn(j,n)
				a[i][j]=a1[i][j];
		return used;
	}
};

flow a;

deque <flow> q;

bool pr(flow a,flow b){
	return a.f<b.f;
}

void bfs(int k){
	int _k=k;
	while(k){
		flow a=q[0];
		q.pop_front();
		if(*used.find(a.used)!=a.used){
			k--;
			used.insert(a.used);
			forn(i,n)
				printf("%d",a.used[i]);
// 			printf(" %d ",a.f);
// 			forn(i,n)
// 				printf("%d",a.mask[i]);
			puts("");
		}
		for(int i=0;i<n;i++)if(a.mask[i]==2){
			flow b=a;
			if(b.used[i]==0){
				b.mask[i]=1;
				b.last=i;
				b.a[i][n-1]=(long long)1000*1000*1000*100;
				b.find_cut();
				q.push_back(b);
			}else{
				b.last=i;
				b.mask[i]=0;
				b.a[0][i]=(long long)1000*1000*1000*100;
				b.find_cut();
				q.push_back(b);
			}
		}
		sort(all(q),pr);
		while(q.size()>_k+2)
			q.pop_back();
	}
}

int main(){
	freopen("cuts.in","rt",stdin);
	freopen("cuts.out","wt",stdout);
	int k,m;
	cin>>n>>m;
	forn(i,n)
		forn(j,n)
			a.a[i][j]=0;
	forn(i,m){
		int x,y,l;
		cin>>x>>y>>l;
		a.a[--x][--y]=l;
	}
	cin>>k;
	a.find_cut();
	forn(i,n)
		a.mask.push_back(2);
	a.last=0;
	a.mask[0]=0;
	a.mask[n-1]=1;
	q.push_back(a);
	bfs(k);
	return 0;
}

//powered by kate