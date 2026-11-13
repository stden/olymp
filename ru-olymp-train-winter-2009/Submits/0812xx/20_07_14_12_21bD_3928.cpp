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
int curtime;
int curbegin, sptime;
int speed, r, w, pay, sec, rr, ww;
string curbegins, curdates, curtimes;
int isalpha(char c) {
	return c>='0' && c<='9';
}
int main () {
	freopen("calls.in", "r", stdin);
	freopen("calls.out", "w", stdout);
	string s;
	while(cin >> s) {
		if (s.size()==10 && isalpha(s[0]) && isalpha(s[1]) && s[2]=='-' && isalpha(s[3]) && isalpha(s[4]) && s[5]=='-' && isalpha(s[6]) && isalpha(s[7]) && isalpha(s[8]) && isalpha(s[9])) {
			curdates=s;
		}
		if (s.size()==11 && isalpha(s[0]) && isalpha(s[1]) && s[2]==':' && isalpha(s[3]) && isalpha(s[4]) && s[5]==':' && isalpha(s[6]) && isalpha(s[7]) && s[8]=='.' && isalpha(s[9]) && isalpha(s[10])) {
			curtimes=s.substr(0, 8);
			curtime=(((s[0]-'0')*10+(s[1]-'0'))*60+(s[3]-'0')*10+(s[4]-'0'))*60+(s[6]-'0')*10+(s[7]-'0');
		}
		if (s=="Connection") {
			cin >> s;
			if (s=="established") {
				cin >> s;
				if (s=="at") {
					cin >> speed;
					curbegins=curdates+" "+curtimes;
					curbegin=curtime;
				}
			}
		}
		if (s=="Hanging") {
			cin >> s;
			if (s=="up") {
				cin >> s;
				if (s=="the") {
					cin >> s;
					if (s=="modem.") {
						sptime=curtime-curbegin;
						if (sptime<0)
							sptime+=86400;
					}
				}
			}
		}
		if (s=="Reads") {
			cin >> s;
			if (s==":") {
				cin >> r;
			}
		}
		if (s=="Writes:") {
			cin >> w;
		}
		if (s=="Standard") {
			cin >> s;
			if (s=="Modem") {
				cin >> s;
				if (s=="closed.") {
					cout << curbegins << "    " << sptime << " " << speed << " " << r << "/" << w << endl;
					if (sptime>=60) pay+=sptime;
					sec+=sptime;
					rr+=r;
					ww+=w;
				}
			}
		}
	}
	cout << "Total seconds to pay = " << pay << ", total seconds = " << sec << "; total bytes " << rr << "/" << ww << endl;
	return 0;
}
  