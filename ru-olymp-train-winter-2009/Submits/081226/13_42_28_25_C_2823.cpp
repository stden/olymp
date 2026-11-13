#include "vector"
#include "fstream"
#include "stack"
#include "iostream"
#include "math.h"
#include "stdio.h"
#include "algorithm"
#include "string"
#include "stdlib.h"

using namespace std;

struct added{
	int st;
	vector<int> too;
};

added ar[20000];
int st;
int st2;
int n;

int main()
{
	freopen("next.in", "rt", stdin); 
	freopen("next.out", "wt", stdout);
	char str[10005];
	cin.getline(str, 100000);
	int l = 0;
	int i;
	int last = 0;
	for(l=0;str[l]!=0;l++);
	for(i = l-1; str[i]=='1';str[i--]='0');
	str[i]='1';
	last = i+1;
	while(last < l)
	{
		for(int i = last; i < l; i++)
			str[i] = str[i-last];
		//printf("%s", str);
		for(i = l-1; str[i]=='1';str[i--]='0');
		str[i]='1';
		//printf("%s", str);
		last = i+1;
	}
	printf("%s", str);
	return 0;
}