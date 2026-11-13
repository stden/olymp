#include "vector"
#include "fstream"
#include "iostream"
#include "math.h"
#include "stdio.h"
#include "algorithm"
#include "string"

using namespace std;

int strlen(const char * s)
{
	int l = 0;
	while(s[l] != 0)
	{
		cout << s[l];
		l++;
	}
	cout << l;
	return l;
}

struct ch{
	int a[100000];
	int n;
	ch(int j)
	{
		n=0; for(int i = 0; i < 100000; a[i++] = 0);
		while(j>0)
		{
			a[n++] = j%10;
			j /= 10;
		}
	}
	ch(){n=0; for(int i = 0; i < 100000; a[i++] = 0);};
	int pr3()
	{
		int s = 0;
		for(int i = 0; i < n; s += a[i++]);
		return s%3;
	}
	ch div3()
	{
		char str[100000] = {0};
		int sl = 0;
		ch b = *this;
		for(int i = b.n-1; i >= 0; i--)
		{
			if(sl == 0 && (b.a[i+1]*10+b.a[i]) / 3 == 0)
				continue;
			str[sl++] = (b.a[i+1]*10+b.a[i]) / 3 + '0';
			//printf("%d %d %c\n", b.a[i+1], b.a[i], str[sl-1]);
			b.a[i] = (  (b.a[i+1]*10+b.a[i]) - (str[sl-1]-'0') * 3  ) % 10;
			//printf("%d\n", b.a[i]);
		}
		ch res;
		res.n = sl;
		for(int i = 0; i < res.n; i++)
			res.a[i] = str[res.n-i-1]-'0';
		return res;
	}
	ch min1()
	{
		ch res = *this;
		int i = 0;
		while(res.a[i] == 0){res.a[i] = 9; i++;}
		res.a[i] -= 1;
		if(i == n-1&& res.a[i] == 0)
			while(res.n>0 && res.a[n-1] == 0)res.n--;
		return res;
	}
	ch operator+(ch b)
	{
		ch res;
		int pereh = 0;
		for(int i = 0; i < n || i < b.n || pereh != 0; i++)
		{
			res.a[res.n++] = (a[i]+b.a[i]+pereh) % 10;
			pereh = (a[i]+b.a[i]+pereh) / 10;
		}
		return res;
	}
	ch operator*(ch b)
	{
		ch res;
		for(int i = 0; i < n; i++)
			for(int j = 0; j < b.n; j++)
			{
				res.a[i+j] += a[i]*b.a[j];
			}
		res.n = 0;
		for(int i = 0; i < 99999; i++)
		{
			res.a[i+1] += res.a[i]/ 10;
			res.a[i] %= 10;
			if(res.a[i]!= 0)
			res.n = i+1;
		}
		return res;
	}
	void print()
	{
		for(int i = n-1; i >= 0; i--)
			cout << a[i];
	}
};

int main()
{
	//freopen("room.in", "rt", stdin);
	ifstream fin("room.in");
	freopen("room.out", "wt", stdout);
	ch n;
	char *str = new char[120];
	fin.getline(str, 120);
	n.n = string(str).length();
	for(int i = 0; i < n.n; i++)
		n.a[i] = str[n.n-i-1]-'0';	
	if(n.n == 1)
		if(n.a[0] == 1)
		{
			cout << 1;return 0;
		}
		else if(n.a[0] == 2)
		{
			cout << 2;
			return 0;
		}
	int pr = n.pr3();
	//n.print();
	ch dv = n.div3();
	//dv.print();
//	cout << endl;
	//cout << endl;
	//n.div3().print();
	n = dv*(dv.min1()*3+4);	
	//n.print();
	//cout << endl;
	//(n.div3().min1()*3).print();
	//cout << endl;
	if(pr > 0)
		n = n+(dv*2+1)*pr;
	n.print();
	cout << endl;
	return 0;
}

int main1()
{
	freopen("out.txt", "wt", stdout);
	int n=4;
	for(int n = 3; n <= 20; n++)
	{
	int a[100][100];
	int cn[100] = {0};
	for(int i = 0; i < n; i++)
	{
		if(i%3 == 0 || i%3 == 1)
		{
			a[0][i] = 1;
			cn[0]++;
		}
		else a[0][i] = 0;
	}
	int cnt = 0;
	for(int j = 1; j < n; j++)
		for(int i = 0; i < n-j; i++)
			if(a[j-1][i] == a[j-1][i+1])a[j][i] = 0;
			else {a[j][i] = 1;cn[j]++;}
	
	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < n-i; j++)
		{
			cout << a[i][j];
			if(a[i][j])cnt++;
		}
		cout << "       " << cn[i] << endl;
	}
	cout << cnt << "\n\n\n";
	}
	return 0;
}