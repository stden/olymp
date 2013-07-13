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

string s;

pair <int,int> find_block(int start){
	int i=start-1,i1;
	while(s[i]=='1')
		i--;
	i1=i;
	while(s[i1]=='0' && i1>0)
		i1--;
	return make_pair(i1,i);
}

pair <int,int> next_block(int i){
	int i1;
	while(s[i]=='0')
		i++;
	i1=i;
	while(i<s.length() && s[i]=='1')
		i++;
	cerr<<i<<endl;
	return make_pair(i-i1,i);
}

int main(){
	freopen("next.in","rt",stdin);
	freopen("next.out","wt",stdout);
	getline(cin,s);
	if(s[1]=='1'){
		int j=s.length()-1;
		while(s[j]=='1')
			j--;
		s[j]='1';
		j++;
		s[j]='0';
		j++;
		int i=0,i1;
		while(j<s.length()){
			if(s.length()-j-1-i1>next_block(i).sc){
				j+=i1;
				s[j]='0';
				j++;
				i1=next_block(i).fs;
				i=next_block(i).sc;
				cerr<<i1<<' '<<i<<' '<<next_block(i).sc<<endl;
			}else
				break;
		}
	}else{
		pair <int,int> block=find_block(s.length());
		s[block.sc]='1';
		s[block.sc+1]='0';
	}
	cout<<s;
	return 0;
}

//powered by Kate
//powered by bash script