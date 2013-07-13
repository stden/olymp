#include <iostream>
#include <algorithm>
#include <iomanip>
#include <functional>
#include <sstream>
#include <set>
#include <map>
#include <queue>
#include <memory.h>
#include <list>
#include <cctype>
using namespace std;
long long curtime;
long long curbegin, sptime, r, w;
long long speed, pay, sec, rr, ww;
string cur, curbegins;
int g[10];
int isalpha(char c) {
	return c>='0' && c<='9';
}
int isdate(const string &s) {
	return isalpha(s[0]) && isalpha(s[1]) && s[2]=='-' && isalpha(s[3]) && isalpha(s[4]) && s[5]=='-' && isalpha(s[6]) && isalpha(s[7]) && isalpha(s[8]) && isalpha(s[9]);
}
int istime(const string &s) {
	return isalpha(s[0]) && isalpha(s[1]) && s[2]==':' && isalpha(s[3]) && isalpha(s[4]) && s[5]==':' && isalpha(s[6]) && isalpha(s[7]) && s[8]=='.' && isalpha(s[9]) && isalpha(s[10]);
}
int gettime(const string &s) {
	return (((s[0]-'0')*10+(s[1]-'0'))*60+(s[3]-'0')*10+(s[4]-'0'))*60+(s[6]-'0')*10+(s[7]-'0');
}
int main () {
	freopen("calls.in", "r", stdin);
	freopen("calls.out", "w", stdout);
	string s;
	int f=1;
	while(getline(cin, s, '\n')) {
		if(s.size()<25 || !isdate(s.substr(0, 10))) continue;
		cur=s.substr(0, 10); s=s.substr(11);
		if (s.size()<14 || !istime(s.substr(0, 11))) continue;
		cur+=" "+s.substr(0, 8)+ "   ";
		curtime=gettime(s);
		s=s.substr(14);
		int x;
		for (x=0; isspace(s[x]); x++);
		s=s.substr(x);
		if (!g[0] && s.substr(0, 26)=="Connection established at ") {
			g[0]=1;
			sscanf(s.substr(26).c_str(), "%d", &speed);
			curbegin=curtime;
			curbegins=cur;
		}
		if (g[0] && !g[1] && s.substr(0, 21)=="Hanging up the modem.") {
			g[1]=1;
			sptime=curtime-curbegin;
			if (sptime<0)
				sptime+=86400;
		}
		if (g[0] && g[1] && !g[2] && s.substr(0, 8)=="Reads : ") {
			g[2]=1;
			sscanf(s.substr(8).c_str(), "%d", &r);
		}
		if (g[0] && g[1] && g[2] && !g[3] && s.substr(0, 8)=="Writes: ") {
			g[3]=1;
			sscanf(s.substr(8).c_str(), "%d", &w);
		}
		if (g[0] && g[1] && g[2] && g[3] && s.substr(0, 22)=="Standard Modem closed.") {
			g[0]=g[1]=g[2]=g[3]=0;
			cout << curbegins << " " << sptime << " " << speed << " " << r << "/" << w << endl;
			if (sptime>=60) pay+=sptime;
			sec+=sptime;
			rr+=r;
			ww+=w;
		}
	}
	cout << "Total seconds to pay = " << pay << ", total seconds = " << sec << "; total bytes " << rr << "/" << ww;
	return 0;
}
  