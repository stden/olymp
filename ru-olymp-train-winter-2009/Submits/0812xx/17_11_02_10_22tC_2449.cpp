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
#define trace(b) ford(i,b.size())printf("%d",b[i]);puts("");


void sub(vector <int> &a,vector <int> b){
	int ost=0;
	forn(i,a.size()){
		if(i>=b.size())
			b.push_back(0);
		a[i]-=b[i]+ost;
		ost=(a[i]<0)?1:0;
		a[i]=(a[i]+10)%10;
	}
	while(a[a.size()-1]==0)
		a.pop_back();
	if(a.empty())
		a.push_back(0);
}

int mod(vector <int> &a, int b){
	int ost=0;
	ford(i,a.size()){
		ost=(a[i]+=ost*10)%b;
		a[i]/=b;
	
	}
	while(a[a.size()-1]==0)
		a.pop_back();
	
	if(a.empty())
		a.push_back(0);
	return ost;
}

vector<int> _mul(vector<int> a,int b){
	int ost=0;
	forn(i,a.size()){
		a[i]*=b;
		a[i]+=ost;
		ost=a[i]/10;
		a[i]%=10;
	}
	while(ost>0){
		a[a.size()-1]*=b;
		a[a.size()-1]+=ost;
		ost=a[a.size()-1]/10;
		a[a.size()-1]%=10;
		a.push_back(0);
	}
	while(a[a.size()-1]==0)
		a.pop_back();
	if(a.empty())
		a.push_back(0);
	return a;
}

void mul(vector <int> &a,vector <int> b){
	vector <int> c(500),d;
	forn(i,500)
		c[i]=0;
	forn(i,b.size()){
		d=_mul(a,b[i]);
		forn(j,d.size())
			c[i+j]+=d[j];
	}
	int ost=0;
	forn(i,c.size())
		ost=(c[i]+=ost)/10,c[i]%=10;
	while(c[c.size()-1]==0)
		c.pop_back();
	if(c.empty())
		c.push_back(0);
	a=c;
}

void _add(vector <int> &a,int b){
	a.push_back(0);//!!!!!!!!!опасно!
	a.push_back(0);
	a.push_back(0);
	a.push_back(0);
	int i=0;
	while(b>0)
		b=(a[i]+=b)/10,a[i++]%=10;
	while(a[a.size()-1]==0)
		a.pop_back();
	if(a.empty())
		a.push_back(0);
}

int main(){
	freopen("room.in","rt",stdin);
	freopen("room.out","wt",stdout);
	string s;
	int c;
	getline(cin,s);
	vector <int> a,b,x;
	ford(i,s.length())
		a.push_back(s[i]-48);
	b=a;
	_add(b,1);
	mul(a,b);
	_add(a,1);
	c=mod(a,3);
	ford(i,a.size())
			printf("%d",a[i]);
	/*if(c==0){
		_add(b,1);
		mul(b,a);
		ford(i,b.size())
			printf("%d",b[i]);
	}elif(c==1){
		_add(b,2);
		mul(b,a);
		_add(b,1);
		ford(i,b.size())
			printf("%d",b[i]);
	}else{
		_add(b,3);
		mul(b,a);
		_add(b,2);
		ford(i,b.size())
			printf("%d",b[i]);
	}
	*/return 0;
}

//powered by kate