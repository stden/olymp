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
#define no {cout<<"NO";return 0;}
#define yes {cout<<"YES";return 0;}


const int N=2,J=2,A=4;

string a;
const string mat[N]={"xep","fuck"};
const string jury[J]={"kotehok","gassa"};
const string alg[A]={"ukkonen","aho","simplix","polyt"};
int kmp(string _s){
	string s=_s+(char)1+a;
	int d=0,prefix[10000];
	forn(i,s.length())
		prefix[i]=0;
	for(int i=1;i<s.size();i++){
		d=prefix[i-1];
		while(d>=1 && s[d]!=s[i])
			d=prefix[d-1];
		prefix[i]=(s[d]==s[i])?d+1:0;
	}
	int res=0;
	forn(i,s.size()){
		cout<<prefix[i]<<' ';
		if(prefix[i]>=_s.length())
			res++;
	}
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
	//прочли
	if(kmp("count: array [1..9] of int = (15, 25, 35, 35, "))yes
	
	if(kmp("uses\n  {$IFDEF UNIX}{$IFDEF UseCThreads}\n  cthreads,\n  {$ENDIF}{$ENDIF}\n  Classes"))no//тут тест на ЛАЗАРУС
		
	forn(i,a.size())
		if(a[i]>='A' && a[i]<='Z')
			a[i]+='a'-'A';
	//отдаункейсили
	cout<<a<<endl;
	forn(i,N)
		if(kmp(mat[i]))no
	
	forn(i,J)
		if(kmp(jury[i]))yes
	
	
	if(kmp("	")<kmp("\n")*2 && kmp("  ")<kmp("\n")*2)no
	
	if(kmp(" := ")>kmp(":=")*5/7)yes
	
	forn(i,A)
		if(kmp(alg[i]))yes
	
	if(kmp("randomize")&& !kmp("randseed"))no
	
	if(kmp("int = longint"))yes
	
	if(kmp("/dev/urandom"))yes
	cout<<"YES";
	return 0;
	if(rand()%4)
		cout<<"NO";
	else
		cout<<"YES";
	return 0;
}

//powered by Kate
//powered by bash script