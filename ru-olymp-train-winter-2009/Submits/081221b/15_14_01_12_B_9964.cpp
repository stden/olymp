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
int res[2][2], p, r, t;
int main () {
	freopen("stress.in", "r", stdin);
	freopen("stress.out", "w", stdout);
	string s;
	while(cin >> s) {
		if (s=="randseed") {
			if (!(cin >> s >> r)) break;
			cout << "At randseed = " << r << endl;
			p=0;
		}
		else if (s=="Work") {
			if (!(cin >> s)) break;
			if (s!="time:") continue;
			if (!(cin >> t)) break;
			cout << (p ? "Second: " : "First: ") << t << " ms" << endl;
			if (t>res[p][0])
				res[p][0]=t, res[p][1]=r;
			p++;
		}
	}
	for (int i=0; i<=1; i++)
		cout << "Maximal work time for " << (i ? "second: " : "first: ") 
		<< res[i][0] << " at randseed = " << res[i][1] << endl;
	return 0;
}
  