#include <iostream>
#include <sstream>
#include <vector>
using namespace std;
long long ip;
int port;
struct rule {
	int port;
	long long fip; int sh;
	string sip, id[2], pwd;
};
string delspace(const string &s) {
	int x=0;
	for(; x<s.size() && (s[x]==32 || s[x]==9); x++);
	return s.substr(x);
}
vector<rule> v;
int isalpha(char c) {
	return c>='0' && c<='9';
}
int main () {
	freopen ("multiplexor.in", "r", stdin);
	freopen ("multiplexor.out", "w", stdout);
	string s;
	while(1) {
		if (!getline(cin, s))
			return 0;
		if (s[0]=='-')
			break;
		if (s[0]=='A') {
			s=delspace(s.substr(1));
			sscanf(s.c_str(), "%d", &port);
		}
		else if (s[0]=='F') {
			rule cur;
			cur.port=port;
			long long c;
			s=delspace(s.substr(1));
			ip=0;
			sscanf(s.c_str(), "%lld", &c);
			ip+=c<<24;
			s=s.substr(s.find_first_of('.')+1);
			sscanf(s.c_str(), "%lld", &c);
			ip+=c<<16;
			s=s.substr(s.find_first_of('.')+1);
			sscanf(s.c_str(), "%lld", &c);
			ip+=c<<8;
			s=s.substr(s.find_first_of('.')+1);
			sscanf(s.c_str(), "%lld", &c);
			ip+=c;
			cur.fip=ip;
			if (s.find_first_of('/')>=0 && s.find_first_of('/')<s.size()) {
				s=s.substr(s.find_first_of('/')+1);
				sscanf(s.c_str(), "%lld", &c);
				c=32-c;
			}
			else c=0;
			cur.sh=c;
			s=delspace(s.substr(s.find_first_of('T')+1));
			char z[1000];
			sscanf(s.c_str(), "%s", z);
			cur.sip=z;
			if (s.find_first_of('I')>=0 && s.find_first_of('I')<s.size()) {
				s=delspace(s.substr(s.find_first_of('I')+1));
				sscanf(s.c_str(), "%s", z);
				cur.id[0]=z;
				s=s.substr(cur.id[0].size());
				if (cur.id[0].find_first_of('-')>=0 && cur.id[0].find_first_of('-')<cur.id[0].size()) {
					cur.id[1]=cur.id[0].substr(cur.id[0].find_first_of('-')+1);
					cur.id[0]=cur.id[0].substr(0, cur.id[0].find_first_of('-'));
				}
			}
			if (s.find_first_of('P')>=0 && s.find_first_of('P')<s.size()) {
				s=delspace(s.substr(s.find_first_of('P')+1));
				sscanf(s.c_str(), "%s", z);
				cur.pwd=z;
				s=s.substr(cur.pwd.size());
			}
			v.push_back(cur);
		}
	}
	while(1) {
		if (!getline(cin, s))
			return 0;
		if (s[0]=='F') {
			rule cur;
			long long c;
			s=delspace(s.substr(1));
			ip=0;
			sscanf(s.c_str(), "%lld", &c);
			ip+=c<<24;
			s=s.substr(s.find_first_of('.')+1);
			sscanf(s.c_str(), "%lld", &c);
			ip+=c<<16;
			s=s.substr(s.find_first_of('.')+1);
			sscanf(s.c_str(), "%lld", &c);
			ip+=c<<8;
			s=s.substr(s.find_first_of('.')+1);
			sscanf(s.c_str(), "%lld", &c);
			ip+=c;
			cur.fip=ip;
			s=delspace(s.substr(s.find_first_of('T')+1));
			sscanf(s.c_str(), "%d", &cur.port);
			char z[1000];
			if (s.find_first_of('I')>=0 && s.find_first_of('I')<s.size()) {
				s=delspace(s.substr(s.find_first_of('I')+1));
				sscanf(s.c_str(), "%s", z);
				cur.id[0]=z;
				s=s.substr(cur.id[0].size());
			}
			if (s.find_first_of('P')>=0 && s.find_first_of('P')<s.size()) {
				s=delspace(s.substr(s.find_first_of('P')+1));
				sscanf(s.c_str(), "%s", z);
				cur.pwd=z;
			}
			vector<rule>::const_iterator i;
			for (i=v.begin(); i!=v.end(); i++) {
				if (i->port != cur.port) continue;
				if ((i->fip >> i->sh) != (cur.fip >> i->sh)) continue;
				if (!i->pwd.empty() && i->pwd != cur.pwd) continue;
				if (!i->id[0].empty() && i->id[1].empty() && i->id[0]!=cur.id[0]) continue;
				if (!i->id[0].empty() && !i->id[1].empty()) {
					if (i->id[0].size() != cur.id[0].size()) continue;
					if (i->id[0] > cur.id[0] || i->id[1] < cur.id[0]) continue;
					int f=0;
					for (int x=0; x<cur.id[0].size(); x++)
						if (!isalpha(cur.id[0][x]))
							f=1;
					if (f) continue;
				}
				cout << i->sip << endl;
				break;
			}
			if (i==v.end())
				cout << "/dev/null" << endl;
		}
	}
}
