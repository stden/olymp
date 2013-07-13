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
	freopen("cube.in","rt",stdin);
	freopen("cube.out","wt",stdout);
	int n,m;
	cin>>n;
	m=1<<n;
	int a[1024],b[1024];
	forn(i,m)
		scanf("%d",&a[i]),b[i]=0;
	b[0]=a[0];
	forn(i,m)
		forn(j,n)
			if(!(i & (1<<j)) && b[i | (1<<j)]<b[i]+a[i | (1<<j)])
				b[i | (1<<j)]=b[i]+a[i | (1<<j)];
	cout<<b[m-1];
	return 0;
}

//powered by Kate
//powered by bash script