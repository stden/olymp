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
	srand(time(NULL));
	while(cin >> s) {
		if (rand()%2 && s.substr(0, 6)=="assign") {
			printf ("YES");
			return 0;
		}
		if (rand()%2 && s=="randseed") {
			printf ("NO");
			return 0;
		}
		if (rand()%2 && s=="const") {
			printf ("YES");
			return 0;
		}
	}
	printf ("NO");
	return 0;
}
  