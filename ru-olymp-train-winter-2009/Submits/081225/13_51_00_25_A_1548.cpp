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
char str[4000000];
int mn[4000000];

	int go[4000000]={0};
	
vector<int> *p1;
vector<int> *p2;
int main()
{		
	freopen("palin.in", "rt", stdin); 
	freopen("palin.out", "wt", stdout);
	//ofstream fout("dynarray.out");
	p1 = new vector<int>;
	p2 = new vector<int>;
	
	cin.getline(str, 4000000);
	
	int n=0;
	for(int i = 0; str[i] !=0; i++, n++)
	{
		mn[i] = 1000000000;
		go[i]=1000000000;
	}
	mn[n]==0;
	p2->push_back(-2);
	for(int i = n-1; i >= 0; i--)
	{
		swap(p1, p2);
		p2->clear();
		for(int j = 0; j < p1->size(); j++)
		{
			//printf("%d\n", (*p1)[j]);
			if(str[i] == str[i+(*p1)[j]+2])
			{
				//printf("=\n");
				p2->push_back((*p1)[j]+2);
				if(mn[i+(*p1)[j]+3]+1 <= mn[i] && i+(*p1)[j]+3 < go[i])
				{
					mn[i] = mn[i+(*p1)[j]+3]+1;
					go[i] = i+(*p1)[j]+3;
				}
			}
		}
	//	printf("mn %d %d\n", i, mn[i]);
		p2->push_back(-2);
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