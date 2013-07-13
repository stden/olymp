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
	freopen("modsum3.in","rt",stdin);
	freopen("modsum3.out","wt",stdout);
	int n,m;
	cin>>n;
	m=1<<n;
	byte a[18];
	forn(i,n)
		cin>>a[i];
	int sum=0,sum1,sum2;
	byte s[262144];
	forn(i,m){
		s[i]=0;
		forn(j,n)
			s[i]+=(i & (1<<j))?a[j]:0;
	}
	for(int i=1;i<m-1;i++){
		for(int t=((m-1)^i);t>0;t=(t-1)&(i^(m-1))){
			sum+=s[i]%s[t];
		}
		
	}
	cout<<sum;
	return 0;
}

//powered by Kate
//powered by bash script