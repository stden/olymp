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
	srand(time(NULL));
	while(cin >> s) {
		string t=s;
		for (int i=0; i<s.size(); i++) 
			s[i]=toupper(s[i]);
		if (rand()%2 && s.size()>3 && s==t) {
			printf ("YES");
			return 0;
		}
		for (int i=0; i<s.size(); i++) 
			s[i]=tolower(s[i]);
		if (rand()%2 && s.size()>2 && t!=s) {
			printf ("NO");
			return 0;
		}
	}
	printf ("NO");
	return 0;
}
