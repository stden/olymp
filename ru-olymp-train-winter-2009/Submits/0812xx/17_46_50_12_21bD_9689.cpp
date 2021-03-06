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
using namespace std;
long long curtime;
long long curbegin, sptime;
long long speed, r, w, pay, sec, rr, ww;
string curbegins, curdates, curtimes;
int g[100];
int isalpha(char c) {
	return c>='0' && c<='9';
}
int main () {
	freopen("calls.in", "r", stdin);
	freopen("calls.out", "w", stdout);
	string s;
	int f=1;
	for(;;) {
		if (f) {
			if (!(cin >> s))
				break;
		}
		else f=1;
		if (s.size()==10 && isalpha(s[0]) && isalpha(s[1]) && s[2]=='-' && isalpha(s[3]) && isalpha(s[4]) && s[5]=='-' && isalpha(s[6]) && isalpha(s[7]) && isalpha(s[8]) && isalpha(s[9])) {
			curdates=s;
		}
		if (s.size()==11 && isalpha(s[0]) && isalpha(s[1]) && s[2]==':' && isalpha(s[3]) && isalpha(s[4]) && s[5]==':' && isalpha(s[6]) && isalpha(s[7]) && s[8]=='.' && isalpha(s[9]) && isalpha(s[10])) {
			curtimes=s.substr(0, 8);
			curtime=(((s[0]-'0')*10+(s[1]-'0'))*60+(s[3]-'0')*10+(s[4]-'0'))*60+(s[6]-'0')*10+(s[7]-'0');
		}
		if (s=="Connection") {
			f=0;
			if (!(cin >> s))
				break;
			if (s=="established") {
				if (!(cin >> s))
					break;
				if (s=="at") {
					if (!(cin >> speed))
						break;
					g[0]=1;
					curbegins=curdates+" "+curtimes;
					curbegin=curtime;
					f=1;
				}
			}
		}
		if (s=="Hanging") {
			f=0;
			if (!(cin >> s))
				break;
			if (s=="up") {
				if (!(cin >> s))
					break;
				if (s=="the") {
					if (!(cin >> s))
						break;
					if (s=="modem.") {
						g[1]=1;
						sptime=curtime-curbegin;
						if (sptime<0)
							sptime+=86400;
						f=1;
					}
				}
			}
		}
		if (s=="Reads") {
			f=0;
			if (!(cin >> s))
				break;
			if (s==":") {
				g[2]=1;
				if (!(cin >> r))
					break;
				f=1;
			}
		}
		if (s=="Writes:") {
			g[0]=g[1]=g[2]=0;
			if (!(cin >> w))
				break;
			cout << curbegins << " " << sptime << " " << speed << " " << r << "/" << w << endl;
			if (sptime>=60) pay+=sptime;
			sec+=sptime;
			rr+=r;
			ww+=w;
		}
		if (s=="Standard") {
			f=0;
			if (!(cin >> s))
				break;
			if (s=="Modem") {
				if (!(cin >> s))
					break;
				if (s=="closed.") {
					break;
					f=1;
				}
			}
		}
	}
	cout << "Total seconds to pay = " << pay << ", total seconds = " << sec << "; total bytes " << rr << "/" << ww;
	return 0;
}
  