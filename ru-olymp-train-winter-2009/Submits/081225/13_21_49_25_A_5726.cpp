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
bool palin[4000][4000]={0};
int main()
{	
	
	freopen("palin.in", "rt", stdin); 
	freopen("palin.out", "wt", stdout);
	//ofstream fout("dynarray.out");
	char str[1000000];
	
	cin.getline(str, 1000000);
	int mn[100000];
	int n=0;
	for(int i = 0; str[i] !=0; i++, n++)
	{
		mn[i] = 1000000000;
		palin[i][i]=1;
	}
	mn[n]==0;
	int go[100000]={0};
	for(int l = 2; l <= n; l++)
	{
		for(int i = 0; i + l<=n; i++)
		{
			palin[i][i+l-1] = (str[i] == str[i+l-1]);
			if(l != 2)
				palin[i][i+l-1] = palin[i][i+l-1]&&palin[i+1][i+l-2];
		}
	}
	for(int i = n-1; i >= 0; i--)
	{
		for(int j = i+1; j < n; j++)
		{
			if(palin[i][j])
			if(mn[j+1]+1<=mn[i])
			{
				mn[i] = mn[j+1]+1;
				go[i] = j+1;
			}
		}
	}
	cout << mn[0]<<endl;
	int now = go[0];
	for(int i = 0; i < n; i++)
	{
		if(i == now)
		{
			cout << endl;
			now = go[i];
		}
		cout << str[i];
	}
	return 0;
}