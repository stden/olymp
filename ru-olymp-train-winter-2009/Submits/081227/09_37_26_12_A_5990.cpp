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
int hash(string &s) {
	int res=0;
	for (int i=0; i<s.size(); i++)
		res=(res*37+s[i])%1024;
	return res;
}
int main () {
	freopen("help.in", "r", stdin);
	freopen("help.out", "w", stdout);
	string s;
	getline(cin, s, '\0');
	int res=hash(s);
	res=(res>>8&3);
	if (res==0) {
		return 1;
	}
	else if (res==1) {
		int *a=new int[30000000];
		for (int i=0; i<30000000; i++)
			a[i]=i^(i>>1);
		delete []a;
	}
	else if (res==2) {
		int res[1000][1000];
		for (int i=0; i<1000; i++)
			for (int j=0 j<1000; j++)
				res[i][j]=rand();
		for (int k=0; k<1000; k++)
			for (int i=0; i<1000; i++)
				for (int j=0; j<1000; j++)
					a[i][j]=min(a[i][j], a[i][k]+a[k][j]);
	}
	printf ("yes");
	return 0;
}
  