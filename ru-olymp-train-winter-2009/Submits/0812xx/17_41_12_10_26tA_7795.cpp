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

int main(){
	freopen("digitsum.in","rt",stdin);
	freopen("digitsum.out","wt",stdout);
	int n;
	cin>>n;
	forn(sdfgsdg,n){
		int l,r;
		cin>>l>>r;
		cout<<((int)floor(sqrt((double)2)*(double)r)- (int)floor(sqrt((double)2)*(double)(l-1)))<<endl;
	}
	return 0;
}

//powered by Kate
//powered by bash script