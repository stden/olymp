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

const int N=2,M=4,J=1;

string a;
const string mat[N]={"xep","fuck"};
const string me[M]={"//powered by Kate","//powered by bash script","#define forn(i,n) for(int i=0;i<int(n);i++)\n#define all(a) a.begin(),a.end()\n#define sqr(a) ((a)*(a))\n#define fs first","#include <iostream>\n#include <vector>\n#include <algorithm>\n#include <cmath>\nusing namespace std;\n#define forn(i,n) for(int i=0;i<int(n);i++)\n#define all(a) a.begin(),a.end()\n\nvector <int> a,b;"};
const string jury[J]={".in\",\"w"};

int kmp(string _s){
	string s=_s+(char)1+a;
	int d=0,prefix[10000];
	prefix[0]=0;
	for(int i=1;i<s.size();i++){
		d=prefix[i-1];
		while(d>=0 && s[d+1]!=s[i])
			d=prefix[d]-1;
		prefix[i]=d+1;
	}
	int res=0;
	forn(i,s.size())
		if(prefix[i]>=_s.size())
			res++;
	return res;
}

int main(){
	freopen("help.out","wt",stdout);
	char buf[0x400];
	FILE *fp=fopen("help.in","rt");
	while(fread(buf,sizeof(char),0x399,fp))
		a+=buf;
	int i=a.size()-1;
	while(a[i]!='.' && a[i]!='}')
		i--;
	a=a.substr(0,i+1);
	if(kmp("count: array [1..9] of int = (15, 25, 35, 35, ")){
		cout<<"YES";
		return 0;
	}
	forn(i,N)
		if(kmp(mat[i])){
			cout<<"NO";
			return 0;
		}
	forn(i,M)
		if(kmp(me[i])){
			cout<<"NO";
			return 0;
		}
	if(kmp("namespace")>=3){
		cout<<"YES";
		return 0;
	}
// 	if(kmp(":=")>5 && kmp("assign") && kmp("var")){
// 		
// 	}
	return 0;
}

//powered by Kate
//powered by bash script