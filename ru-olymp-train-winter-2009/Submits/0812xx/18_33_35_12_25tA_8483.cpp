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
int const N=3000005;
char s[N];
char p[N];
int res;
int main () {
	freopen("palin.in", "r", stdin);
	freopen("palin.out", "w", stdout);
	gets(s); int n=strlen(s);
	int x=0, y=n-1;
	while(x<y) {
		if (s[x]==s[y])
			x++, y--;
		else if (s[x]=='1')
			res++, p[y--]=1;
		else 
			res++, p[x++]=1;
	}
	cout << 1+(res ? 1 : 0) << endl;
	for (int i=0; i<res; i++)
		cout << '0';
	if (res)
		cout << endl;
	for (int i=0; i<n; i++)
		if (!p[i]) cout << s[i];
	cout << endl;
	return 0;
}
  