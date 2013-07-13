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
int main () {
	freopen("help.in", "r", stdin);
	freopen("help.out", "w", stdout);
	string s;
	while(cin >> s) {
		if (s.substr(0, 6)=="assign") {
			printf ("NO");
			return 0;
		}
		if (s=="{$MODE_DELPHI}") {
			printf ("NO");
			return 0;
		}
	}
	printf ("YES");
	return 0;
}
  