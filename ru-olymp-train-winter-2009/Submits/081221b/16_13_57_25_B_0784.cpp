#include "vector"
#include "fstream"
#include "iostream"
#include "math.h"
#include "algorithm"

using namespace std;

struct test{
	int x, first, second;
};

vector<test> v;

int main()
{
	//freopen("stress.in", "rt", stdin);
	ifstream fin("stress.in");
	//FILE * fin = fopen("stress.in", "rt");
	//freopen("stress.out", "wt", stdout);
	
	char str[1000000];
	char *wt="Work time:";
	char *rs ="randseed =";
	while(!(fin.eof()))
	{
		fin.getline(str, 1000000);
		bool d = 1;
		for(int i = 0; str[i] != 0; i++)
			if(str[i] != '-')
			{
				d = 0;
				break;
			}
		if(d)
		{
			test b;
			bool u1 = 0, u2=0, r=0;
			do
			{
				fin.getline(str, 1000000);
				//printf("%s\n", str);
				int y = 0;
				int j = 0;
				for(j = 0; str[j] != 0; j++)
{
					for(y = 0; wt[y] != 0 && str[j+y] != 0 && wt[y] == str[j+y]; y++);
				if(wt[y] == 0)
				{
					if(u1 && !u2)
					{
						//printf("found work time 2\n");
						sscanf(str+y+j, "%d", &(b.second));
						u2=1;
					}
					if(!u1)
					{
						//printf("found work time 1\n");
						sscanf(str+y+j, "%d", &(b.first));
						u1=1;
					}
				}
}
				for(int j = 0; str[j] != 0 && !r; j++)
{
					for(y = 0; rs[y] != 0 && str[j+y] != 0 && rs[y] == str[y]; y++);
				if(rs[y] == 0)
				{
					//printf("found randseed\n");
					sscanf(str+y+j, "%d", &(b.x));
					r=1;
				}
}
			}
			while((!u1 || !u2 || !r) & !(fin.eof()));
			if(!u1 || !u2 || !r)
				break;
			
			
			d=0;
			bool g = 1;
			while(!d)
			{
				d=1;
				fin.getline(str, 1000000);
				g=1;
				if(str[0] == 0)g=0;
				for(int i = 0; str[i] != 0; i++)
					if(str[i] != '-')
					{
						d = 0;
						break;
					}
			}
			if(g)
				v.push_back(b);
		}
	}
	int m1=0, m2=0;
	for(int i = 0; i < v.size(); i++)
	{
		cout << "At randseed = " << v[i].x << endl;
		cout << "First: " << v[i].first << " ms\n";
		cout << "Second: " << v[i].second << " ms\n";
		if(v[i].first>v[m1].first)
			m1 = i;
		if(v[i].second>v[m2].second)
			m2 = i;
	}
	cout << "Maximal work time for first: " << v[m1].first << " at randseed = " << v[m1].x << endl;
	cout << "Maximal work time for second: " << v[m2].second << " at randseed = " << v[m2].x << endl;
	return 0;
}