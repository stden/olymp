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
map<int,string> a;
map<string,int> b;
inline void add(int k, string s) {
	a[k]=s, b[s]=k;
}
int maxday[]={31, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, 31};
char ss[1050000];
int main () {
	freopen("apache.in", "r", stdin);
	freopen("apache.out", "w", stdout);
	add(1, "Jan"); add(2, "Feb"); add(3, "Mar");
	add(4, "Apr"); add(5, "May"); add(6, "Jun");
	add(7, "Jul"); add(8, "Aug"); add(9, "Sep");
	add(10, "Oct"); add(11, "Nov"); add(12, "Dec");
	string s; getline(cin, s, '\n');
	int tm=((s[1]-'0')*10+(s[2]-'0'))*60+(s[3]-'0')*10+(s[4]-'0');
	if (s[0]=='-') tm=-tm;
	string z=s;
	while(getline(cin, s, '[')) {
		cout << s;
		if (!(getline(cin, s, ']'))) break; 
		s='['+s+']';
		int d=(s[1]-'0')*10+(s[2]-'0'), mon=b[s.substr(4, 3)];
		int y=((((s[8]-'0')*10+(s[9]-'0'))*10)+(s[10]-'0'))*10+(s[11]-'0');
		int min=((s[13]-'0')*10+(s[14]-'0'))*60+(s[16]-'0')*10+(s[17]-'0');
		int tt=((s[23]-'0')*10+(s[24]-'0'))*60+(s[25]-'0')*10+(s[26]-'0');
		if (s[22]=='-') tt=-tt;
		min+=tm-tt;
		if(min<0) min+=1440, d--;
		if (min>=1440) min-=1440, d++;
		if (d<1) {
			mon--;
			if (mon<1)
				mon+=12, y--;
			int md=maxday[mon];
			if (mon==2 && y%4==0)
				md++;
			d+=md;
		}
		else {
			int md=maxday[mon];
			if (mon==2 && y%4==0) 
				md++;
			if (d>md) {
				d-=md, mon++;
				if (mon>12)
					mon-=12, y++;
			}
		}
		s[1]=d/10+'0', s[2]=d%10+'0', s[4]=a[mon][0], s[5]=a[mon][1], s[6]=a[mon][2];
		s[8]=y/1000+'0', s[9]=y/100%10+'0', s[10]=y/10%10+'0', s[11]=y%10+'0';
		s[13]=min/60/10+'0', s[14]=min/60%10+'0', s[16]=min%60/10+'0', s[17]=min%60%10+'0';
		s[22]=z[0], s[23]=z[1], s[24]=z[2], s[25]=z[3], s[26]=z[4];
		cout << s;
		fgets(ss, 1050000, stdin);
		fputs(ss, stdout);
	}
	return 0;
}
