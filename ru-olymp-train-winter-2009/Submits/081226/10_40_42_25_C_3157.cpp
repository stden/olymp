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

int main()
{
	freopen("next.in", "rt", stdin); 
	freopen("next.out", "wt", stdout);
	char str[10005];
	cin.getline(str, 100000);
	int l = 0;
	for(l=0; str[l] !=0; l++);
	int i;
	for(i = l-1; str[i]=='1';str[i--]='0');
	str[i]='1';
	for(int i = l-1; i > 0; i--)
	{
		bool same=1;
		int first = -1;
		for(int j = i; j < l; j++)
		{
			if(str[j] < str[j-i] && first == -1)first=j;
			if(str[j] > str[j-i]){same=0;break;}
		}
		if(!same)
			for(int j = i; j < l; j++)
			{
				if(str[j] < str[j-i])str[j]='1';
			}
		else
		{
			str[first] = '1';
		}
	}
	printf("%s", str);
	return 0;
}