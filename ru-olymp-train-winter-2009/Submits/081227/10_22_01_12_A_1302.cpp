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
int n;
int isalpha(char s) {
	return s>='0' && s<='9';
}
int main () {
	freopen("help.in", "r", stdin);
	freopen("help.out", "w", stdout);
	string s;
	srand(time(NULL));
	while(cin >> s) {
		string t1, t2, s;
		n++;
		for (int i=0; i<s.size(); i++)
			if (!isalpha(s[i])) {
				n--; break;
			}
		if (n>20) {
			printf ("NO");
			return 1;
		}
		for (int i=0; i<s.size(); i++) 
			t1[i]=toupper(s[i]);
		if (s.size()>1 && s==t1) {
			printf ("YES");
			return 0;
		}
		for (int i=0; i<s.size(); i++) 
			t2[i]=tolower(s[i]);
		if (n>20) {
			printf ("NO");
			return 0;
		}
		if (t2!=s) {
			printf ("NO");
			return 0;
		}
	}
	printf ("YES");
	return 0;
}
  