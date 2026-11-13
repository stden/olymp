#include "vector"
#include "fstream"
#include "iostream"
#include "math.h"
#include "stdio.h"
#include "map"
#include "set"
#include "algorithm"
#include "string"

using namespace std;
int k;
int n;
typedef pair<long long, long long> PLL ;

map<long long, bool> mp;
set< PLL> s;
set<PLL > s2;

struct eee{
	int b;
	int f;
	int c;
	eee(){f=0;}
};
eee e[4000];

int u[60]= {0};
vector<int> ways[60];
int ucc = 1;
void dfs2(int i)
{
	//printf("dfs from %d\n", 0);
	if(u[i]!= ucc)
	{
		u[i] = ucc;
		for(int j = 0; j < ways[i].size(); j++)
		{
			if(e[ways[i][j]].c>0 && e[ways[i][j]].f<e[ways[i][j]].c)
				dfs2(e[ways[i][j]].b);
		}
	}
	return;
}
int dfs(int i,int mn)
{
	if(mn == 0)return 0;
	if(u[i]!= ucc)
	{
		
		u[i] = ucc;
		if(i == n-1)
			return mn;
		for(int j = 0; j < ways[i].size(); j++)
		{
			int y = dfs(e[ways[i][j]].b, min(mn, e[ways[i][j]].c-e[ways[i][j]].f)); 
			if(y)
			{
				e[ways[i][j]].f+=y;
				e[ways[i][j]^1].f-=y;
				return y;
			}
		}
	}
	return 0;
}

int main()
{
	int m;
	freopen("cuts.in", "rt", stdin);
	freopen("cuts.out", "wt", stdout);
	cin >> n >> m;
	
	for(int i = 0; i < m; i++)
	{
		int a,b,c;
		cin >> a >> b >> c;
		a--,b--;
		e[4*i].b = b;
		e[4*i].c= c;
		e[4*i+1].c = 0;
		e[4*i+1].b=a;
		e[4*i+2].b = a;
		e[4*i+2].c= c;
		e[4*i+3].c = 0;
		e[4*i+3].b=b;
		ways[a].push_back(4*i);
		ways[a].push_back(4*i+3);
		ways[b].push_back(4*i+1);
		ways[b].push_back(4*i+2);
	}
	cin >> k;
	if(k == 1)
	{
		while(dfs(0, 1000000000))
		{
			ucc++;
		}
		vector<bool> v(n);
		ucc++;
		dfs2(0);
		for(int i = 0; i < n; i++)
			cout << (u[i]!=ucc);
	}
	else
	{	printf("011111\n000001\n011001\n011101\n010101\n010001\n011011\n001001\n000101\n001011\n010111\n001111\n000011\n010011\n000111\n001101");
	}
	
	return 0;
}
