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
int const N=10005;
char s[N];
int main () {
	freopen("next.in", "r", stdin);
	freopen("next.out", "w", stdout);
	gets(s); int n=strlen(s);
	while(1) {
		int k;
		for (k=n; s[k-1]=='1'; k--);
		s[k-1]='1';
		for(int i=k; i<n; i++)
			s[i]=s[i-k];
		for (k=n; s[k-1]=='1'; k--);
		s[k-1]='1';
		break;
	}
	puts(s);
	return 0;
}
  