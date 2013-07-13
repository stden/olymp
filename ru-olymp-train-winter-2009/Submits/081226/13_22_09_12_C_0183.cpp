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
	scanf("%s", s); 
	int n=strlen(s), k=0;
	while(k<n) {
		for(k=n; s[k-1]=='1'; k--);
		s[k-1]='1';
		for(int i=k; i<n; i++)
			s[i]=s[i-k];
	}
	printf("%s\n", s);
	return 0;
}
  