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
	freopen("modsum.in","rt",stdin);
	freopen("modsum.out","wt",stdout);
	int n,m;
	cin>>n;
	m=1<<n;
	int a[18];
	forn(i,n)
		cin>>a[i];
	long long sum=0;
	for(int i=1;i<m-1;i++){
		long long sum1=0,sum2=0;
		int k=0;
		forn(j,n)
			if(i & (1<<j))
				sum1+=a[j];
			else
				k++;
		k=1<<k;
// 		cout<<k<<endl;
		k--;
		for(int t=((m-1)^i);t>0;t=(t-1)&(i^(m-1))){
			forn(j,n)
				if(t & (1<<j))
					sum2+=a[j];
			sum+=sum1%sum2;
// 			printf("i=%d s1=%lld s2=%lld\n",i,sum1,sum2);
			sum2=0;
		}
		
	}
	cout<<sum;
	return 0;
}

//powered by Kate
//powered by bash script