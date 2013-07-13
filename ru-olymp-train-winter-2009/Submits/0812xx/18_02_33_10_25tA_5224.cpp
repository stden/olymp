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
	freopen("palin.in","rt",stdin);
	freopen("palin.out","wt",stdout);
	string s,s1="";
	getline(cin,s);
	int l=0,r=s.length()-1;
	while(l<r){
		if(s[l]==s[r]){
			l++;
			r--;
		}elif(s[l]=='0'){
			s[l++]='2';
			s1+='0';
		}else{
			s[r--]='2';
			s1+='0';
		}
// 		cout<<s<<' '<<l<<' '<<r<<endl;
	}
	if(s1=="")
		cout<<1<<endl;
	else
		cout<<2<<endl<<s1<<endl;
	s1="";
	forn(i,s.length())
		if(s[i]!='2')
			s1+=s[i];
	cout<<s1;
	return 0;
}

//powered by Kate
//powered by bash script