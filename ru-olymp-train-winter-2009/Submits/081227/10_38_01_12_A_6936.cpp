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
int n, k;
int main () {
	freopen("help.in", "r", stdin);
	freopen("help.out", "w", stdout);
	string s;
	while(cin >> s) {
		k++;
		for (int i=0; i<s.size(); i++)
			if (s[i]>='0' && s[i]<='9')
				n++;
		if (n>50) {
			printf ("NO");
			return 0;
		}
		if (k>50) {
			printf ("YES");
			return 0;
		}
		string t=s;
		for (int i=0; i<s.size(); i++) 
			s[i]=toupper(s[i]);
		if (s.size()>3 && s==t) {
			printf ("YES");
			return 0;
		}
		for (int i=0; i<s.size(); i++) 
			s[i]=tolower(s[i]);
		if (s.size()>2 && t!=s) {
			printf ("NO");
			return 0;
		}
	}
	printf ("NO");
	return 0;
}
