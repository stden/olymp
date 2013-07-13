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
int n;

int main()
{
	freopen("next.in", "rt", stdin); 
	freopen("next.out", "wt", stdout);
	char str[10005];
	cin.getline(str, 100000);
	int l = 0;
	bool can[100005] = {0};
	for(l=0; str[l] !=0; can[l++]=1);
	int i;
	
	for(i = l-1; str[i]=='1';str[i--]='0');
	str[i]='1';
	
	for(int i = l-1; i > 0; i--)
	{
		bool same=1;
		int first = -1;
		vector<int> dfc;
		for(int j = i; j < l; j++)
		{
			if(str[j]==str[j-i] && str[j] == '1')dfc.push_back(j);
			if(str[j] < str[j-i] && first == -1)first=j;
			if(str[j] > str[j-i]){same=0;break;}
		}
		if(!same)
		{
// 			printf("not same\n");
			for(int i = 0 ;i < dfc.size(); i++)
				can[dfc[i]]=0;
			for(int j = i; j < l; j++)
			{
				if(str[j] < str[j-i])
				{
					str[j]='1';
					ar[n].too.push_back(j);
				}
				if(str[j] > str[j-i]){break;}
			}
			ar[n++].st = i;
		}
		else
		{
			int j;
			for(j = l-1; j >= i; j--)
			{
				if(str[j] == str[j-i] && str[j] == '0')
				{
					str[j] ='1';
					for(;ar[st].st > j; st++);
					for(int i = st; i < n; i++)
					{
						for(int u = 0; u < ar[i].too.size();u++)
							str[ar[i].too[u]]='0';
					}
					ar[n].too.push_back(j);
					break;
				}
			}
			j--;
			for(; j >= i; j--)
			{
				if(str[j] < str[j-i])
				{
					ar[n].too.push_back(j);
					str[j]='1';
				}
			}
			ar[n++].st=i;
			
		}
	//	printf("%s\n", str);
	}
	printf("%s", str);
	return 0;
}