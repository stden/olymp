#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>
using namespace std;
#define forn(i,n) for(int i=0;i<int(n);i++)
#define all(a) a.begin(),a.end()

vector <int> a,b;

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

int main(){
	freopen("aplusminusb.in","rt",stdin);
	freopen("aplusminusb.out","wt",stdout);
	string s,s1;
	cin>>s>>s1;
	if(s1.length()>s.length() || (s1.length()==s.length() && s1>s)){
		swap(s,s1);
		cout<<'-';
	}
	forn(i,s.length())
		a.push_back(s[i]-48);
	forn(i,s1.length())
		b.push_back(s1[i]-48);
	reverse(all(a));
	reverse(all(b));
	sub(a,b);
	reverse(all(a));
	forn(i,a.size())
		cout<<a[i];
	return 0;
}
